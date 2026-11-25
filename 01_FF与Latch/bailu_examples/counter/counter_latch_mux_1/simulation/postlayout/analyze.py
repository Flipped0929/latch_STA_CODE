"""Check transistor waveforms, measure timing/power and export static figures."""
from pathlib import Path
import argparse
import csv
import importlib.util
import json
import os
import re
import sys

HERE=Path(__file__).resolve().parent
extra=os.environ.get('POSTLAYOUT_PYTHONPATH','/tmp/counter_ngspice_python')
if not all(importlib.util.find_spec(m) for m in ['numpy','matplotlib']) and Path(extra).is_dir():
    sys.path.insert(0,extra)
os.environ.setdefault('MPLCONFIGDIR','/tmp/counter-postlayout-matplotlib')
os.environ.setdefault('XDG_CACHE_HOME','/tmp/counter-postlayout-cache')
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt


def read_raw(path):
    data=path.read_bytes()
    header, binary=data.split(b'Binary:\n',1)
    header=header.decode()
    points=int(re.search(r'No\. Points:\s+(\d+)',header)[1])
    number=int(re.search(r'No\. Variables:\s+(\d+)',header)[1])
    names=[m[1].lower() for m in re.finditer(r'^\s*\d+\s+(\S+)\s+\S+\s*$', header.split('Variables:',1)[1],re.M)]
    assert len(names)==number
    values=np.frombuffer(binary,dtype='<f8')
    assert values.size==points*number and np.all(np.isfinite(values))
    values=values.reshape(points,number)
    return {name:values[:,i] for i,name in enumerate(names)}


def crossings(t,v,rising=True,level=.9):
    ids=np.flatnonzero((v[:-1]<level)&(v[1:]>=level) if rising else (v[:-1]>level)&(v[1:]<=level))
    return t[ids]+(level-v[ids])/(v[ids+1]-v[ids])*(t[ids+1]-t[ids])


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('--name',default='nominal')
    args=parser.parse_args()
    name=args.name
    cfg=json.loads((HERE/'results'/f'{name}_config.json').read_text())
    wave=read_raw(HERE/'results'/f'{name}.raw')
    t=wave['time']*1e9
    assert np.all(np.diff(t)>=0)
    assert abs(float(t[-1])-cfg['stop_ns'])<1e-6, 'Incomplete transient waveform'
    p=cfg['period_ns']; start=cfg['start_ns']
    def at(vector,when): return float(np.interp(when,t,wave[vector.lower()]))
    def logic(value): return 0 if value<=cfg['low_limit_V'] else 1 if value>=cfg['high_limit_V'] else None
    def decode(when):
        voltage=[at(f'v(count{bit})',when) for bit in range(4)]
        bits=[logic(v) for v in voltage]
        return (sum(b<<i for i,b in enumerate(bits)) if None not in bits else None),voltage
    expected=0
    checks=[]
    for cycle in range(cfg['cycles']):
        if cycle in cfg['reset_cycles']:
            expected=0
        elif cycle not in cfg['hold_cycles']:
            expected=(expected+1)%16
        sample=start+(cycle+cfg['sample_fraction'])*p
        measured,voltage=decode(sample)
        checks.append(dict(cycle=cycle,time_ns=sample,expected=expected,measured=measured,
                           passed=measured==expected,**{f'count{b}_V':v for b,v in enumerate(voltage)}))
    with (HERE/'results'/f'{name}_samples.csv').open('w') as f:
        writer=csv.DictWriter(f,fieldnames=list(checks[0])); writer.writeheader(); writer.writerows(checks)

    reset_checks=[]
    for label,instant in [('initial',2.),('asynchronous',cfg['reset_assert_center_ns']+.8)]:
        for pin,vector in cfg['monitor_vectors'].items():
            if pin.endswith('/Q'):
                voltage=at(vector,instant)
                reset_checks.append(dict(test=label,pin=pin,time_ns=instant,voltage_V=voltage,passed=logic(voltage)==0))
    holdmask=(t>=start+24*p+.3)&(t<=start+32*p-.1)
    hold=[]
    for bit in range(4):
        voltage=wave[f'v(count{bit})'][holdmask]
        desired=(8>>bit)&1
        hold.append(dict(bit=bit,expected=desired,min_V=float(voltage.min()),max_V=float(voltage.max()),
                         passed=bool(voltage.min()>=1.44 if desired else voltage.max()<=.36)))

    def average_power(begin,end):
        times=np.r_[begin,t[(t>begin)&(t<end)],end]
        current=np.interp(times,t,wave['i(vdd)'])
        value=float(np.trapezoid(-1.8*current,times)/(end-begin))
        return dict(begin_ns=begin,end_ns=end,average_W=value,average_uW=value*1e6,
                    energy_per_cycle_pJ=value*p*1e3)
    power={'active':average_power(start+4*p,start+20*p),
           'hold':average_power(start+25*p,start+31*p)}
    clock_pins={pin:vector for pin,vector in cfg['monitor_vectors'].items() if pin.endswith('/GATE')}
    edges={pin:(crossings(t,wave[vector.lower()],True),crossings(t,wave[vector.lower()],False))
           for pin,vector in clock_pins.items()}
    gaps=[]
    for cycle in range(2,cfg['cycles']-2):
        def edge(pin,rise,source):
            candidates=edges[pin][0 if rise else 1]
            candidates=candidates[(candidates>source-.05)&(candidates<source+.8)]
            assert len(candidates)==1,(pin,cycle,candidates)
            return float(candidates[0])
        fall1=[edge(pin,False,start+(cycle+.495)*p) for pin in clock_pins if pin.startswith('state_phi1_')]
        rise2=[edge(pin,True,start+(cycle+.505)*p) for pin in clock_pins if pin.startswith('state_phi2_')]
        fall2=[edge(pin,False,start+(cycle+.995)*p) for pin in clock_pins if pin.startswith('state_phi2_')]
        rise1=[edge(pin,True,start+(cycle+1+.005)*p) for pin in clock_pins if pin.startswith('state_phi1_')]
        gaps.append(dict(cycle=cycle,phi1_to_phi2_ps=1000*(min(rise2)-max(fall1)),
                         phi2_to_next_phi1_ps=1000*(min(rise1)-max(fall2))))
    with (HERE/'results'/f'{name}_clock_gaps.csv').open('w') as f:
        writer=csv.DictWriter(f,fieldnames=list(gaps[0])); writer.writeheader(); writer.writerows(gaps)

    output_edges={bit:{r:crossings(t,wave[f'v(count{bit})'],r) for r in [True,False]} for bit in range(4)}
    timing=[]
    for cycle,row in enumerate(checks):
        old=0 if cycle==0 else checks[cycle-1]['expected']
        if cycle in cfg['reset_cycles'] or not row['passed']:
            continue
        for bit in range(4):
            target=(row['expected']>>bit)&1
            if target==((old>>bit)&1): continue
            source=start+(cycle+.505)*p
            candidates=output_edges[bit][bool(target)]
            candidates=candidates[(candidates>=source)&(candidates<=row['time_ns'])]
            if len(candidates):
                timing.append(dict(cycle=cycle,bit=bit,rising=bool(target),clock_source_50_ns=source,
                                   output_50_ns=float(candidates[-1]),delay_ps=1000*(float(candidates[-1])-source)))
    with (HERE/'results'/f'{name}_clock_to_output.csv').open('w') as f:
        writer=csv.DictWriter(f,fieldnames=['cycle','bit','rising','clock_source_50_ns','output_50_ns','delay_ps'])
        writer.writeheader();writer.writerows(timing)

    summary=dict(scenario=name,period_ns=p,temperature_C=25,supply_V=1.8,
                 cycles_checked=len(checks),cycles_passed=sum(r['passed'] for r in checks),
                 failures=[r for r in checks if not r['passed']],
                 reset_checks=reset_checks,hold_checks=hold,
                 all_functional_checks_passed=all(r['passed'] for r in checks+reset_checks+hold),
                 power=power,clock_gaps_ps={key:dict(min=min(r[key] for r in gaps),max=max(r[key] for r in gaps))
                                           for key in ['phi1_to_phi2_ps','phi2_to_next_phi1_ps']},
                 source_phi2_to_output_delay_ps={str(bit):dict(min=min(r['delay_ps'] for r in timing if r['bit']==bit),
                                       max=max(r['delay_ps'] for r in timing if r['bit']==bit)) for bit in range(4)},
                 raw_points=len(t),vdd_current_peak_mA=float((-wave['i(vdd)']).max()*1e3))
    (HERE/'results'/f'{name}_summary.json').write_text(json.dumps(summary,indent=2)+'\n')
    # Export compact, uniformly sampled top-level waveforms. Full adaptive
    # transistor/sink waveforms remain in the ngspice binary RAW file.
    sampled=np.arange(0,t[-1],.010)
    public=['v(clk_1)','v(clk_2)','v(rst_n)','v(en)',*(f'v(count{b})' for b in range(4)),'i(vdd)']
    matrix=np.column_stack([sampled,*[np.interp(sampled,t,wave[v]) for v in public]])
    np.savetxt(HERE/'results'/f'{name}_waveforms.csv',matrix,delimiter=',',
               header='time_ns,'+','.join(public),comments='',fmt='%.8g')

    plt.rcParams.update({'font.size':10,'axes.spines.top':False,'axes.spines.right':False})
    fig,axes=plt.subplots(6,1,figsize=(15,10),sharex=True,constrained_layout=True)
    axes[0].plot(t,wave['v(clk_1)'],label='clk_1',lw=.7)
    axes[0].plot(t,wave['v(clk_2)'],label='clk_2',lw=.7);axes[0].legend(ncol=2,loc='upper right')
    axes[1].plot(t,wave['v(rst_n)'],label='rst_n',lw=.9)
    axes[1].plot(t,wave['v(en)'],label='en',lw=.9);axes[1].legend(ncol=2,loc='upper right')
    for bit in range(4):
        axes[bit+2].plot(t,wave[f'v(count{bit})'],lw=.8,color=f'C{bit+2}')
        axes[bit+2].set_ylabel(f'count[{bit}]\n(V)')
    axes[0].set_ylabel('clocks\n(V)');axes[1].set_ylabel('control\n(V)')
    for ax in axes:
        ax.set_ylim(-.15,2.);ax.grid(alpha=.18);ax.set_xlim(0,cfg['stop_ns'])
    axes[-1].set_xlabel('Time (ns)')
    fig.suptitle(f'Postlayout transistor transient | TT, 25 C, 1.8 V | T={p:g} ns | '
                 f'count checks {summary["cycles_passed"]}/{len(checks)}')
    fig.savefig(HERE/'plots'/f'{name}_waveforms.png',dpi=170)
    fig.savefig(HERE/'plots'/f'{name}_waveforms.svg')
    plt.close(fig)
    fig,axes=plt.subplots(3,1,figsize=(12,7),sharex=True,constrained_layout=True)
    zoom=(start+14*p,start+18*p)
    mask=(t>=zoom[0])&(t<=zoom[1])
    axes[0].plot(t[mask],wave['v(clk_1)'][mask],label='clk_1 source',lw=1)
    axes[0].plot(t[mask],wave['v(clk_2)'][mask],label='clk_2 source',lw=1)
    for phase,inst in [(1,'state_phi1_bit0'),(2,'state_phi2_bit0')]:
        vector=cfg['monitor_vectors'][inst+'/GATE'].lower()
        axes[0].plot(t[mask],wave[vector][mask],ls='--',lw=.9,label=f'phi{phase} latch GATE')
    axes[0].set_ylabel('Clock (V)');axes[0].legend(ncol=2,fontsize=8)
    for bit in range(4):axes[1].plot(t[mask],wave[f'v(count{bit})'][mask],label=f'count[{bit}]',lw=.9)
    axes[1].set_ylabel('Outputs (V)');axes[1].legend(ncol=4,fontsize=8)
    axes[2].plot(t[mask],-1.8e3*wave['i(vdd)'][mask],color='C3',lw=.8)
    axes[2].set_ylabel('VDD power (mW)');axes[2].set_xlabel('Time (ns)')
    for ax in axes:ax.grid(alpha=.18);ax.set_xlim(*zoom)
    fig.suptitle('Carry/rollover detail: distributed RC, coupled nets and real transistor delay')
    fig.savefig(HERE/'plots'/f'{name}_detail.png',dpi=170)
    fig.savefig(HERE/'plots'/f'{name}_detail.svg')
    plt.close(fig)
    print('FUNCTIONAL:',summary['cycles_passed'],'/',len(checks),'ALL_CHECKS:',summary['all_functional_checks_passed'])
    print('POWER_uW:',{key:round(v['average_uW'],6) for key,v in power.items()})
    print('CLOCK_GAPS_ps:',summary['clock_gaps_ps'])


if __name__=='__main__':main()
