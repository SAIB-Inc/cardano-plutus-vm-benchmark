# Cardano Plutus VM Benchmark Results

**Date:** 2026-03-11

## Environment
```
date: 2026-03-11T21:25:28+00:00
kernel: 5.15.167.4-microsoft-standard-WSL2
cpu: AMD Ryzen 9 9900X3D 12-Core Processor
cores: 24
memory: 47Gi
```

## Summary (geometric mean across all scripts)

| VM | Language | Geo Mean | vs Fastest |
|---|---|---|---|
| **Scalus Hybrid JIT (Scala / JVM)** | Scala / JVM | 116.89 us | 1.00x |
| **Scalus CEK (Scala / JVM)** | Scala / JVM | 275.13 us | 2.35x |
| **Chrysalis (C# / .NET AOT)** | C# / .NET AOT | 419.18 us | 3.59x |
| **Chrysalis (C# / .NET JIT)** | C# / .NET JIT | 423.13 us | 3.62x |

## Per-Script Results

| Script | Scalus Hybrid JIT (Scala / JVM) | Scalus CEK (Scala / JVM) | Chrysalis (C# / .NET JIT) | Chrysalis (C# / .NET AOT) |
|---|---|---|---|---|
| auction_1-1 | **31.84 us** | 122.32 us | 196.38 us | 194.00 us |
| auction_1-2 | 777.40 us | **498.94 us** | 698.38 us | 713.65 us |
| auction_1-3 | 586.83 us | **476.84 us** | 726.90 us | 701.52 us |
| auction_1-4 | **49.15 us** | 154.56 us | 233.66 us | 228.93 us |
| auction_2-1 | **38.12 us** | 119.18 us | 204.09 us | 196.87 us |
| auction_2-2 | 1.13 ms | **480.55 us** | 716.18 us | 720.87 us |
| auction_2-3 | 828.28 us | **613.21 us** | 880.52 us | 904.17 us |
| auction_2-4 | 543.10 us | **466.90 us** | 698.04 us | 713.02 us |
| auction_2-5 | **43.34 us** | 152.92 us | 234.70 us | 240.77 us |
| coop-1 | - | - | **203.90 us** | 204.98 us |
| coop-2 | - | - | **609.91 us** | 620.99 us |
| coop-3 | - | - | **1.98 ms** | 2.15 ms |
| coop-4 | - | - | **772.00 us** | 831.35 us |
| coop-5 | - | - | **383.04 us** | 388.88 us |
| coop-6 | - | - | **520.72 us** | 539.63 us |
| coop-7 | - | - | **270.26 us** | 280.72 us |
| crowdfunding-success-1 | **32.13 us** | 140.35 us | 231.51 us | 225.70 us |
| crowdfunding-success-2 | **33.57 us** | 140.31 us | 230.54 us | 222.53 us |
| crowdfunding-success-3 | **32.05 us** | 139.28 us | 239.29 us | 230.28 us |
| currency-1 | **29.62 us** | 221.14 us | 286.22 us | 279.27 us |
| escrow-redeem_1-1 | **62.12 us** | 245.38 us | 393.36 us | 377.60 us |
| escrow-redeem_1-2 | **61.50 us** | 247.28 us | 376.38 us | 385.06 us |
| escrow-redeem_2-1 | **71.29 us** | 288.25 us | 426.12 us | 423.86 us |
| escrow-redeem_2-2 | **70.49 us** | 293.48 us | 425.81 us | 423.59 us |
| escrow-redeem_2-3 | **67.40 us** | 297.99 us | 430.79 us | 417.62 us |
| escrow-refund-1 | **15.84 us** | 104.08 us | 215.95 us | 205.83 us |
| future-increase-margin-1 | **27.36 us** | 177.74 us | 289.52 us | 286.62 us |
| future-increase-margin-2 | **99.11 us** | 394.35 us | 535.49 us | 541.69 us |
| future-increase-margin-3 | **112.73 us** | 411.28 us | 533.98 us | 547.39 us |
| future-increase-margin-4 | 614.19 us | **362.42 us** | 617.74 us | 617.16 us |
| future-increase-margin-5 | 1.23 ms | **635.38 us** | 959.43 us | 927.43 us |
| future-pay-out-1 | **32.03 us** | 175.67 us | 289.68 us | 290.35 us |
| future-pay-out-2 | **114.93 us** | 391.56 us | 563.30 us | 540.19 us |
| future-pay-out-3 | **97.65 us** | 391.02 us | 538.64 us | 542.76 us |
| future-pay-out-4 | 1.36 ms | **623.85 us** | 944.59 us | 968.04 us |
| future-settle-early-1 | **27.51 us** | 182.01 us | 284.00 us | 284.14 us |
| future-settle-early-2 | **105.01 us** | 388.29 us | 548.95 us | 549.61 us |
| future-settle-early-3 | **93.96 us** | 388.50 us | 545.91 us | 530.07 us |
| future-settle-early-4 | 1.16 ms | **476.15 us** | 738.26 us | 730.30 us |
| game-sm-success_1-1 | 407.09 us | **274.51 us** | 480.43 us | 463.80 us |
| game-sm-success_1-2 | **31.63 us** | 135.26 us | 204.10 us | 202.71 us |
| game-sm-success_1-3 | 525.66 us | **479.31 us** | 702.62 us | 703.00 us |
| game-sm-success_1-4 | **36.13 us** | 155.79 us | 231.71 us | 227.60 us |
| game-sm-success_2-1 | 431.62 us | **273.54 us** | 480.65 us | 456.88 us |
| game-sm-success_2-2 | **32.44 us** | 137.19 us | 204.24 us | 198.30 us |
| game-sm-success_2-3 | 557.04 us | **464.18 us** | 717.34 us | 710.58 us |
| game-sm-success_2-4 | **36.65 us** | 155.38 us | 228.09 us | 225.95 us |
| game-sm-success_2-5 | 564.59 us | **492.07 us** | 726.10 us | 688.40 us |
| game-sm-success_2-6 | **36.99 us** | 157.66 us | 229.69 us | 226.88 us |
| guardrail-sorted-large | - | - | **404.08 us** | 422.00 us |
| guardrail-sorted-small | - | - | 102.83 us | **97.83 us** |
| guardrail-unsorted-large | - | - | **544.70 us** | 579.19 us |
| guardrail-unsorted-small | - | - | **97.39 us** | 97.50 us |
| multisig-sm-01 | 502.24 us | **281.13 us** | 508.72 us | 492.43 us |
| multisig-sm-02 | 539.76 us | **279.12 us** | 492.60 us | 481.05 us |
| multisig-sm-03 | 559.21 us | **300.96 us** | 501.49 us | 484.53 us |
| multisig-sm-04 | 512.92 us | **290.44 us** | 518.91 us | 502.79 us |
| multisig-sm-05 | 756.37 us | **414.28 us** | 680.63 us | 648.21 us |
| multisig-sm-06 | 530.58 us | **283.94 us** | 532.16 us | 493.10 us |
| multisig-sm-07 | 552.52 us | **280.50 us** | 511.52 us | 491.50 us |
| multisig-sm-08 | 549.47 us | **285.88 us** | 495.63 us | 492.88 us |
| multisig-sm-09 | 505.65 us | **287.88 us** | 503.12 us | 497.13 us |
| multisig-sm-10 | 723.89 us | **410.14 us** | 663.77 us | 647.39 us |
| ping-pong-1 | **231.53 us** | 253.18 us | 413.33 us | 417.88 us |
| ping-pong-2 | **223.28 us** | 243.64 us | 431.62 us | 415.82 us |
| ping-pong_2-1 | **85.34 us** | 146.92 us | 314.87 us | 288.69 us |
| prism-1 | **13.37 us** | 112.22 us | 176.49 us | 170.96 us |
| prism-2 | 405.46 us | **287.33 us** | 490.94 us | 489.38 us |
| prism-3 | **68.35 us** | 268.53 us | 376.95 us | 385.83 us |
| pubkey-1 | **11.77 us** | 104.08 us | 158.65 us | 157.85 us |
| stablecoin_1-1 | - | **707.21 us** | 1.11 ms | 1.09 ms |
| stablecoin_1-2 | **31.58 us** | 132.28 us | 206.98 us | 200.57 us |
| stablecoin_1-3 | - | **796.45 us** | 1.24 ms | 1.22 ms |
| stablecoin_1-4 | **34.05 us** | 141.55 us | 213.51 us | 209.54 us |
| stablecoin_1-5 | - | **1.01 ms** | 1.55 ms | 1.51 ms |
| stablecoin_1-6 | **41.08 us** | 170.90 us | 248.26 us | 247.64 us |
| stablecoin_2-1 | - | **697.40 us** | 1.11 ms | 1.11 ms |
| stablecoin_2-2 | **32.37 us** | 134.06 us | 197.10 us | 198.89 us |
| stablecoin_2-3 | - | **790.75 us** | 1.22 ms | 1.22 ms |
| stablecoin_2-4 | **32.82 us** | 139.62 us | 213.13 us | 207.65 us |
| token-account-1 | **23.06 us** | 134.52 us | 237.99 us | 233.37 us |
| token-account-2 | **40.11 us** | 242.30 us | 348.53 us | 344.61 us |
| uniswap-1 | **43.09 us** | 319.01 us | 434.97 us | 441.40 us |
| uniswap-2 | **32.99 us** | 157.25 us | 258.94 us | 257.42 us |
| uniswap-3 | - | **1.19 ms** | 1.63 ms | 1.67 ms |
| uniswap-4 | **55.95 us** | 224.31 us | 314.88 us | 304.17 us |
| uniswap-5 | - | **759.10 us** | 1.11 ms | 1.11 ms |
| uniswap-6 | **53.60 us** | 215.53 us | 303.67 us | 303.17 us |
| vesting-1 | **80.64 us** | 249.63 us | 410.40 us | 400.62 us |

---
*Generated by [cardano-plutus-vm-benchmark](https://github.com/saib-inc/cardano-plutus-vm-benchmark)*