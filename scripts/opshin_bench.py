"""Benchmark UPLC CEK machine using plutus_use_cases flat-encoded scripts."""

import os
import sys
import time
import cbor2
from uplc.tools import unflatten, eval

BENCH_DIR = os.path.expanduser(
    "~/Projects/Chrysalis-Plutus/benchmarks/data/plutus_use_cases"
)
WARMUP = 3
MIN_ITERS = 20
TIME_BUDGET_S = 2.0


def fmt_ns(ns: int) -> str:
    if ns >= 1_000_000_000:
        return f"{ns / 1e9:.2f} s "
    if ns >= 1_000_000:
        return f"{ns / 1e6:.2f} ms"
    if ns >= 1_000:
        return f"{ns / 1e3:.2f} us"
    return f"{ns} ns"


files = sorted(f for f in os.listdir(BENCH_DIR) if f.endswith(".flat"))
if not files:
    print(f"No .flat files in {BENCH_DIR}", file=sys.stderr)
    sys.exit(1)

# CBOR-wrap raw flat bytes for unflatten()
scripts = {}
for f in files:
    raw = open(os.path.join(BENCH_DIR, f), "rb").read()
    scripts[f.removesuffix(".flat")] = cbor2.dumps(raw)

# JIT warmup
first = list(scripts.values())[0]
for _ in range(20):
    prog = unflatten(first)
    eval(prog)

print(f"Found {len(files)} benchmark files\n")
print("plutus_use_cases benchmarks (Python / OpShin uplc)")
print("=" * 90)

grand_total_ns = 0
grand_total_iters = 0

for name, cbor_flat in scripts.items():
    # Verify it works
    try:
        prog = unflatten(cbor_flat)
        eval(prog)
    except Exception:
        print(f"  {name:<35} SKIP (eval error)")
        continue

    # Warmup
    for _ in range(WARMUP):
        prog = unflatten(cbor_flat)
        eval(prog)

    # Measured
    samples = []
    total_s = 0.0
    while len(samples) < MIN_ITERS or total_s < TIME_BUDGET_S:
        t0 = time.perf_counter_ns()
        prog = unflatten(cbor_flat)
        eval(prog)
        elapsed = time.perf_counter_ns() - t0
        samples.append(elapsed)
        total_s += elapsed / 1e9
        if len(samples) >= 10_000:
            break

    samples.sort()
    n = len(samples)
    mean = sum(samples) // n
    median = samples[n // 2] if n % 2 else (samples[n // 2 - 1] + samples[n // 2]) // 2
    mn, mx = samples[0], samples[-1]
    var = sum((s - mean) ** 2 for s in samples) / n
    stddev = int(var**0.5)

    grand_total_ns += sum(samples)
    grand_total_iters += n

    print(
        f"  {name:<35} {n:5} runs  {fmt_ns(mean):>12}  "
        f"+/- {fmt_ns(stddev):>10}  [{fmt_ns(mn):>10} .. {fmt_ns(mx):>10}]"
    )

print("=" * 90)
if grand_total_iters > 0:
    grand_mean = grand_total_ns // grand_total_iters
    print(f"  Grand total: {grand_total_iters} iterations, mean {fmt_ns(grand_mean)}/eval")
