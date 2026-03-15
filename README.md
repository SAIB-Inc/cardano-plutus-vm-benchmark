# Cardano Plutus VM Benchmark

Reproducible, cross-language benchmark suite for Plutus (UPLC) virtual machine implementations.

Builds 6 VMs from source inside Docker, runs each VM's **native benchmark framework**, and generates a unified comparison report. [View full results](https://saib-inc.github.io/cardano-plutus-vm-benchmark/)

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

*Geometric mean of 78 plutus_use_cases scripts. Lower is better.*

## VMs Benchmarked

| VM | Language | Benchmark Framework | Repository |
|---|---|---|---|
| **uplc-turbo** | Rust | Criterion.rs | [pragma-org/uplc](https://github.com/pragma-org/uplc) |
| **Plutuz** | Zig | Custom (JSON) | [utxo-company/plutuz](https://github.com/utxo-company/plutuz) |
| **Chrysalis** | C# / .NET | BenchmarkDotNet (JIT + AOT) | [SAIB-Inc/Chrysalis](https://github.com/SAIB-Inc/Chrysalis) |
| **Plutigo** | Go | testing.B | [blinklabs-io/plutigo](https://github.com/blinklabs-io/plutigo) |
| **blaze-plutus** | TypeScript | Vitest bench (V8 + JSC) | [butaneprotocol/blaze-cardano](https://github.com/butaneprotocol/blaze-cardano) |
| **opshin-uplc** | Python | Custom | [OpShin/uplc](https://github.com/OpShin/uplc) |

## What's Measured

Each VM: **flat-decode + CEK evaluate** on 78 real-world Plutus smart contract scripts (auction, escrow, uniswap, stablecoin, etc.).

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
