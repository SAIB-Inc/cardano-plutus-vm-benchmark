# Cardano Plutus VM Benchmark

Reproducible, cross-language benchmark suite for Plutus (UPLC) virtual machine implementations.

Builds 14 VM variants from source inside Docker, runs each VM's **native benchmark framework**, and generates a unified comparison report. [View full results](https://saib-inc.github.io/cardano-plutus-vm-benchmark/)

## Latest Results (2026-03-10)

> AMD Ryzen 9 9900X3D, 24 cores, 47 GB RAM, Ubuntu 24.04 (WSL2)

| VM | Language | Geo Mean | vs Fastest |
|---|---|---|---|
| **Plutuz** | Zig | 408 us | 1.00x |
| **uplc-turbo** | Rust | 495 us | 1.21x |
| **Chrysalis (JIT)** | C# / .NET | 549 us | 1.35x |
| **Chrysalis (AOT)** | C# / .NET | 567 us | 1.39x |
| **blaze-plutus (V8)** | TypeScript | 1.17 ms | 2.88x |
| **blaze-plutus (JSC)** | TypeScript | 1.18 ms | 2.89x |
| **Plutigo** | Go | 2.28 ms | 5.59x |
| **opshin** | Python | 169 ms | 414x |

*Geometric mean of 89 plutus_use_cases scripts. Lower is better. The table above predates Scalus integration; the next Ryzen refresh will include both Scalus variants.*

### Scalus performance (preview, dev hardware)

> Apple M3 Max, 14 cores, 36 GB RAM, macOS arm64, Docker — not directly comparable to the Ryzen table above

| VM | Language | Geo Mean | vs CEK baseline |
|---|---|---|---|
| **Scalus JIT** (Hybrid, UPLC→JVM) | Scala / GraalVM 25 | **84 µs** | **3.85x faster** |
| **Scalus CEK** | Scala / GraalVM 25 | 280 µs | 1.16x faster |

*CEK baseline is Scalus CEK on JDK 21 (325 µs). Both rows use GraalVM JDK 25, compact object headers (JEP 519), Scala-friendly inlining, and `MAX_STACK_DEPTH=25000` for the JIT NativeStack path. See [#37](https://github.com/SAIB-Inc/cardano-plutus-vm-benchmark/pull/37) for the engineering details.*

## VMs Benchmarked

| VM | Language | Benchmark Framework | Repository |
|---|---|---|---|
| **uplc-turbo** | Rust | Criterion.rs | [pragma-org/uplc](https://github.com/pragma-org/uplc) |
| **Plutuz** | Zig | Custom (JSON) | [utxo-company/plutuz](https://github.com/utxo-company/plutuz) |
| **Chrysalis** | C# / .NET | BenchmarkDotNet (JIT + AOT) | [SAIB-Inc/Chrysalis](https://github.com/SAIB-Inc/Chrysalis) |
| **Plutigo** | Go | testing.B | [blinklabs-io/plutigo](https://github.com/blinklabs-io/plutigo) |
| **blaze-plutus** | TypeScript | Vitest bench (V8 + JSC) | [butaneprotocol/blaze-cardano](https://github.com/butaneprotocol/blaze-cardano) |
| **opshin-uplc** | Python | Custom | [OpShin/uplc](https://github.com/OpShin/uplc) |
| **Julc** | Java | JMH (CEK) | [bloxbean/julc](https://github.com/bloxbean/julc) |
| **llvm-uplc** | C++ / LLVM | Custom (`uplcbench`, JSON) | [SeungheonOh/llvm-uplc](https://github.com/SeungheonOh/llvm-uplc) |
| **Scalus** | Scala / GraalVM 25 | JMH (CEK + Hybrid JIT) | [scalus3/scalus](https://github.com/scalus3/scalus) |

## What's Measured

Each VM: **flat-decode + CEK evaluate** on 89 real-world Plutus smart contract scripts (auction, escrow, uniswap, stablecoin, etc.).

All VMs use the same canonical `.flat` test data committed in `data/plutus_use_cases/`.

## Quick Start

```bash
# Build and run all benchmarks
docker compose up

# Or step by step
docker compose build
docker compose run --rm benchmark

# Run specific VMs only
docker compose run --rm -e BENCH_VMS=chrysalis,uplc-turbo benchmark
```

Results are written to `./results/<date>/`:
- `unified.csv` — all VMs, all scripts, nanosecond precision
- `report.md` — markdown comparison table with geometric means
- Per-VM raw output logs

## Updating VM Versions

Edit `.env` to change pinned git SHAs, then rebuild:

```bash
# Edit .env with new SHAs
docker compose build --no-cache
docker compose run --rm benchmark
```

## Project Structure

```
data/plutus_use_cases/    # 78 canonical .flat benchmark scripts
Dockerfile                # Multi-stage: build all VMs, single ubuntu:24.04 runtime
docker-compose.yml        # One-command orchestration
.env              # Pinned git SHAs and toolchain versions
scripts/                  # Per-VM runner scripts + orchestrator
parsers/                  # Output normalizers (one per framework)
report/                   # Unified CSV -> markdown report generator
results/                  # Git-tracked historical results
```

## Methodology

See [METHODOLOGY.md](METHODOLOGY.md) for details on fairness, statistical methodology, and limitations.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## TODO

- [ ] Add Aiken UPLC (Rust, [aiken-lang/aiken](https://github.com/aiken-lang/aiken) `crates/uplc`) — needs custom bench harness, no native benchmarks exist
- [ ] Add Haskell plutus-core (IOG reference implementation) — requires GHC + cabal Docker setup

## License

[MIT](LICENSE)
