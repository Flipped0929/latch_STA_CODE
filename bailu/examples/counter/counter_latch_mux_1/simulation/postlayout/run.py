"""Run transistor + extracted interconnect ngspice transient analysis."""
from pathlib import Path
import argparse
import json
import os
import subprocess

from prepare import HERE, PDK, prepare


def make_deck(name='nominal', period=1.75, cycles=66, max_step_ps=5):
    pins = json.loads((HERE/'netlists/pin_nodes.json').read_text())
    start, edge = 4., .100
    # Complete the final finite-slew phi2 falling edge before ending the deck.
    stop = start + cycles*period + .2
    def pwl(points):
        return 'PWL('+' '.join(f'{t:.9f}n {v:.9g}' for t,v in points)+')'
    def clock(phase):
        rise = start + (0.005 if phase==1 else .505)*period
        # Built-in periodic source avoids accumulated PWL breakpoint roundoff.
        return f'PULSE(0 1.8 {rise-edge/2:.9f}n {edge:.9f}n {edge:.9f}n {.49*period-edge:.9f}n {period:.9f}n)'
    # Change en in the quiet interval before the next phi1 opening.
    disable = start+24*period-.4
    enable = start+32*period-.4
    reset_on = start+48*period+.4*period
    reset_off = start+50*period-.4
    reset = [(0,0),(start-.9,0),(start-.8,1.8),
             (reset_on-edge/2,1.8),(reset_on+edge/2,0),
             (reset_off-edge/2,0),(reset_off+edge/2,1.8),(stop,1.8)]
    en = [(0,1.8),(disable-edge/2,1.8),(disable+edge/2,0),
          (enable-edge/2,0),(enable+edge/2,1.8),(stop,1.8)]
    signals=['v(clk_1)','v(clk_2)','v(rst_n)','v(en)',*(f'v(count{b})' for b in range(4)), 'i(vdd)']
    monitors={}
    for inst in sorted({s.split('/')[0] for s in pins if s.startswith('state_')}):
        for pin in ['GATE','Q']:
            vector = f'v(xdut.{pins[inst+"/"+pin]})'
            if vector not in signals:
                signals.append(vector)
            monitors[inst+'/'+pin] = vector
    deck = [f'Transistor postlayout counter: {name}; TT 25C 1.8V; full interconnect RC',
            '.include "netlists/tt_used_models.spice"',
            '.include "netlists/sky130_cells.spice"',
            '.include "netlists/counter_postlayout.spice"',
            '.temp 25', '.option reltol=1e-4 abstol=1e-12 vntol=1e-6 method=gear maxord=2 minbreak=1e-15',
            'VDD vdd 0 1.8', 'VCLK1 clk_1 0 '+clock(1), 'VCLK2 clk_2 0 '+clock(2),
            'VRST rst_n 0 '+pwl(reset), 'VEN en 0 '+pwl(en),
            'Xdut clk_1 clk_2 rst_n en vdd 0 count3 count2 count1 count0 counter_postlayout',
            *(f'Cload{b} count{b} 0 10f' for b in range(4)),
            '.save '+' '.join(signals),
            f'.tran 2p {stop:.9f}n 0 {max_step_ps:.9f}p', '.control',
            'set noaskquit', 'set filetype=binary',
            'run',
            f'write results/{name}.raw '+' '.join(signals),
            f'meas tran pwr_current_avg AVG i(vdd) from={start+4*period:.9f}n to={start+20*period:.9f}n',
            'quit', '.endc', '.end']
    path=HERE/(name+'.cir')
    path.write_text('\n'.join(deck)+'\n')
    config=dict(name=name,period_ns=period,cycles=cycles,start_ns=start,stop_ns=stop,
                edge_0_100_ps=100,max_step_ps=max_step_ps,monitor_vectors=monitors,
                hold_cycles=list(range(24,32)),reset_cycles=[48,49],
                reset_assert_center_ns=reset_on,reset_release_center_ns=reset_off,
                reset_initial_release_center_ns=start-.85,
                sample_fraction=.985,low_limit_V=.36,high_limit_V=1.44)
    (HERE/'results'/(name+'_config.json')).write_text(json.dumps(config,indent=2)+'\n')
    return path


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('--prepare-only', action='store_true')
    parser.add_argument('--name', default='nominal')
    parser.add_argument('--period', type=float, default=1.75)
    parser.add_argument('--max-step-ps', type=float, default=5)
    args=parser.parse_args()
    prepare()
    (HERE/'.spiceinit').write_text('set ngbehavior=hsa\nset skywaterpdk\nset ng_nomodcheck\nset num_threads=1\noption klu\n')
    deck=make_deck(args.name,args.period,max_step_ps=args.max_step_ps)
    if args.prepare_only:
        return
    log=HERE/'logs'/(args.name+'.log')
    with log.open('w') as f:
        subprocess.run(['ngspice','-b',str(deck)],cwd=HERE,stdout=f,stderr=subprocess.STDOUT,check=True)
    text=log.read_text()
    assert 'No. of Data Rows' in text and 'simulation(s) aborted' not in text.lower()
    assert (HERE/'results'/(args.name+'.raw')).exists()
    print('NGSPICE_COMPLETE:',args.name,log)


if __name__=='__main__':
    main()
