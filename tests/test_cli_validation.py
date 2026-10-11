"""Smoke-test reports and exit codes without executing YTO/ELL."""
import pathlib
import subprocess
import sys
import tempfile

root = pathlib.Path(__file__).resolve().parents[1]
binary = pathlib.Path(sys.argv[1]).resolve()
with tempfile.TemporaryDirectory(prefix='howard-cli-') as temp:
    report = pathlib.Path(temp) / 'report.csv'
    def run(source, params):
        return subprocess.run([str(binary), str(source), '2', '100', *params,
                               '--report', str(report)],
                              capture_output=True, text=True, timeout=30)
    success = run(root / 'benchmark/s27.blif.out', ['0.1'] * 4 + ['0.4'])
    assert success.returncode == 0, success.stdout + success.stderr
    assert 'Howard/LP validation: PASS' in success.stdout
    assert 'Howard certificate: max violation=' in success.stdout
    assert 'cyclic SCCs: 1' in success.stdout
    assert report.is_file() and report.stat().st_size > 0
    saved = report.read_bytes()
    failed = run(root / 'tests/fixtures/empty.out', ['0'] * 4 + ['0.4'])
    assert failed.returncode == 2, failed.stdout + failed.stderr
    assert 'Howard=NoCycle' in failed.stderr and 'LP=InputError' in failed.stderr
    assert 'Howard diagnostics:' in failed.stderr
    assert 'SUMMARY' not in failed.stdout
    assert report.read_bytes() == saved, 'Failed run overwrote the previous report'
    report.unlink()
    failed = run(root / 'tests/fixtures/empty.out', ['0'] * 4 + ['0.4'])
    assert failed.returncode == 2 and not report.exists()
    zero = run(root / 'tests/fixtures/zero.out', ['0'] * 4 + ['0.4'])
    assert zero.returncode == 0, zero.stdout + zero.stderr
print('CLI PASS: success report, failure exit=2, no invalid report, preserved old report, zero-delay boundary')
