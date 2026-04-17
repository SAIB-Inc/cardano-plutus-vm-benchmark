# Methodology

## What is Measured

Each benchmark iteration performs:

1. **Flat decode** — deserialize a `.flat`-encoded UPLC program into an AST
2. **CEK evaluate** — run the decoded program through the CEK machine with unlimited budget

This is the end-to-end cost of evaluating a Plutus script from its on-chain representation.

## Test Data

78 flat-encoded Plutus smart contract scripts from the `plutus-use-cases` test suite. These are real-world contracts covering:

- Auction, Crowdfunding, Currency, Escrow
- Futures (settle, pay-out, increase-margin)
- Game state machines, Multisig state machines
- Ping-pong, Prism, Pubkey
- Stablecoin, Token account, Uniswap, Vesting

Script sizes range from 3 KB to 13 KB. All VMs use the same canonical copies from `data/plutus_use_cases/`.

## Why Native Benchmarks

Each VM uses its own benchmark framework rather than a uniform harness:

| VM | Framework | Warmup | Min Iterations | Time Budget |
|---|---|---|---|---|
| Chrysalis | BenchmarkDotNet | Automatic (pilot + overhead) | 50 | Auto |
| uplc-turbo | Criterion.rs | Automatic (warmup phase) | Auto | Auto |
| Plutigo | Go testing.B | Automatic (b.N scaling) | Auto | 5s |
| blaze-plutus | Vitest bench | Automatic | Auto | Auto |
| Plutuz | Custom | 5 iterations | 50 | 5s |
| opshin-uplc | Custom | 5 iterations | 50 | 5s |
| llvm-uplc | Custom (`uplcbench`) | 5 iterations | 50 | 5s |

Each framework handles warmup, iteration count, and outlier detection using its own proven methodology. Reimplementing this in a uniform harness would be less accurate and harder to maintain.

## Fairness Constraints

- **Same data**: all VMs decode the same 78 `.flat` files
- **Same machine**: all VMs run inside a single Docker container (`ubuntu:24.04`, glibc)
- **Sequential execution**: VMs run one at a time to avoid CPU contention
- **Pinned versions**: exact git SHAs recorded in `versions.env`
- **No custom harnesses**: each VM's own benchmark code is used unmodified

## Unified Output

All results are normalized to a common CSV schema:

```csv
vm,script,mean_ns,median_ns,min_ns,max_ns,stddev_ns,iterations
```

Times are in **nanoseconds**. The summary uses **geometric mean** across all 78 scripts, which is standard for cross-benchmark comparison (it handles the wide range of script complexities without being dominated by outliers).

## Limitations

- **Different statistical methodologies**: each framework computes mean/median/stddev differently. BenchmarkDotNet and Criterion are the most sophisticated; Go bench and the custom frameworks are simpler.
- **Go bench lacks stddev/min/max**: only reports mean ns/op in default output.
- **JIT warmup variance**: .NET and Node.js/Bun have JIT compilation, meaning early iterations are slower. Their frameworks account for this, but it's a fundamentally different execution model than ahead-of-time compiled VMs.
- **Memory comparison**: each VM uses different allocators and GC strategies. Memory numbers are not directly comparable across languages.
- **Docker overhead**: container execution adds minimal but non-zero overhead vs bare metal. This affects all VMs equally.

## Reproducing

Anyone with Docker can reproduce results:

```bash
git clone https://github.com/saib-inc/cardano-plutus-vm-benchmark.git
cd cardano-plutus-vm-benchmark
docker compose up
```

For the most consistent results, run on a dedicated machine with no other workloads.
