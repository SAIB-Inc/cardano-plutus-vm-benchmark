# Cardano Plutus VM Benchmark Results

**Date:** 2026-04-08

## Environment
```
date: 2026-04-08T20:26:30+00:00
kernel: 5.15.167.4-microsoft-standard-WSL2
cpu: AMD Ryzen 9 9900X3D 12-Core Processor
cores: 24
memory: 47Gi
```

## Summary (geometric mean across all scripts)

*Note: VMs that fail or skip a script are assigned the slowest competitor's time for that script.*

| VM | Language | Geo Mean | vs Fastest |
|---|---|---|---|
| **Scalus Hybrid JIT (Scala / JVM)** | Scala / JVM | 169.09 us | 1.00x |
| **Plutigo (Go)** | Go | 280.28 us | 1.66x |
| **Scalus CEK (Scala / JVM)** | Scala / JVM | 280.63 us | 1.66x |

### Script Coverage

| VM | Passed | Failed | Missing | Total |
|---|---|---|---|---|
| Scalus Hybrid JIT (Scala / JVM) | 89 | 0 | 0 | 89 |
| Plutigo (Go) | 89 | 0 | 0 | 89 |
| Scalus CEK (Scala / JVM) | 89 | 0 | 0 | 89 |

## Per-Script Results

| Script | Scalus Hybrid JIT (Scala / JVM) | Scalus CEK (Scala / JVM) | Plutigo (Go) |
|---|---|---|---|
| auction_1-1 | **27.50 us** | 121.80 us | 135.59 us |
| auction_1-2 | 794.59 us | 488.74 us | **444.63 us** |
| auction_1-3 | 579.01 us | 477.35 us | **440.43 us** |
| auction_1-4 | **39.96 us** | 152.18 us | 159.37 us |
| auction_2-1 | **27.30 us** | 119.94 us | 135.13 us |
| auction_2-2 | 753.08 us | 481.34 us | **439.49 us** |
| auction_2-3 | 795.32 us | 627.25 us | **527.01 us** |
| auction_2-4 | 671.89 us | 479.28 us | **440.38 us** |
| auction_2-5 | **46.72 us** | 153.45 us | 159.08 us |
| coop-1 | **63.05 us** | 153.21 us | 150.29 us |
| coop-2 | **217.63 us** | 497.28 us | 442.54 us |
| coop-3 | **726.52 us** | 1.74 ms | 1.02 ms |
| coop-4 | **282.22 us** | 650.90 us | 508.55 us |
| coop-5 | **121.96 us** | 268.62 us | 287.03 us |
| coop-6 | **185.24 us** | 458.31 us | 380.13 us |
| coop-7 | **87.64 us** | 215.07 us | 204.73 us |
| crowdfunding-success-1 | **32.81 us** | 139.59 us | 160.69 us |
| crowdfunding-success-2 | **36.52 us** | 141.15 us | 160.38 us |
| crowdfunding-success-3 | **34.40 us** | 144.92 us | 161.74 us |
| currency-1 | **31.11 us** | 185.38 us | 178.19 us |
| escrow-redeem_1-1 | **59.64 us** | 250.82 us | 252.55 us |
| escrow-redeem_1-2 | **62.46 us** | 247.91 us | 245.86 us |
| escrow-redeem_2-1 | **71.97 us** | 290.93 us | 269.05 us |
| escrow-redeem_2-2 | **76.13 us** | 295.76 us | 269.21 us |
| escrow-redeem_2-3 | **68.27 us** | 295.63 us | 270.25 us |
| escrow-refund-1 | **18.68 us** | 112.44 us | 160.09 us |
| future-increase-margin-1 | **35.02 us** | 180.66 us | 177.95 us |
| future-increase-margin-2 | **116.56 us** | 392.55 us | 348.90 us |
| future-increase-margin-3 | **125.95 us** | 392.41 us | 325.44 us |
| future-increase-margin-4 | 1.06 ms | **367.52 us** | 415.90 us |
| future-increase-margin-5 | 1.61 ms | 656.73 us | **616.33 us** |
| future-pay-out-1 | **29.36 us** | 181.02 us | 178.66 us |
| future-pay-out-2 | **131.39 us** | 394.46 us | 324.18 us |
| future-pay-out-3 | **135.70 us** | 393.64 us | 324.11 us |
| future-pay-out-4 | 1.50 ms | 638.11 us | **600.54 us** |
| future-settle-early-1 | **33.35 us** | 209.10 us | 184.56 us |
| future-settle-early-2 | **146.18 us** | 501.39 us | 328.58 us |
| future-settle-early-3 | **136.28 us** | 455.08 us | 324.30 us |
| future-settle-early-4 | 1.46 ms | **481.80 us** | 482.51 us |
| game-sm-success_1-1 | 464.92 us | **281.82 us** | 323.27 us |
| game-sm-success_1-2 | **33.63 us** | 139.96 us | 135.64 us |
| game-sm-success_1-3 | 595.55 us | 533.61 us | **432.30 us** |
| game-sm-success_1-4 | **35.66 us** | 161.09 us | 150.81 us |
| game-sm-success_2-1 | 453.43 us | **278.73 us** | 320.46 us |
| game-sm-success_2-2 | **31.84 us** | 136.14 us | 135.83 us |
| game-sm-success_2-3 | 882.34 us | 480.29 us | **431.27 us** |
| game-sm-success_2-4 | **37.69 us** | 159.65 us | 150.44 us |
| game-sm-success_2-5 | 619.91 us | 483.66 us | **428.94 us** |
| game-sm-success_2-6 | **36.33 us** | 167.30 us | 150.42 us |
| guardrail-sorted-large | **298.30 us** | 385.44 us | 433.86 us |
| guardrail-sorted-small | 99.19 us | **57.13 us** | 80.84 us |
| guardrail-unsorted-large | **344.17 us** | 565.20 us | 502.70 us |
| guardrail-unsorted-small | 93.53 us | **47.90 us** | 82.84 us |
| multisig-sm-01 | 620.54 us | **290.96 us** | 356.53 us |
| multisig-sm-02 | 603.35 us | **281.92 us** | 344.62 us |
| multisig-sm-03 | 831.35 us | **284.84 us** | 347.53 us |
| multisig-sm-04 | 648.73 us | **292.31 us** | 372.73 us |
| multisig-sm-05 | 831.61 us | **417.56 us** | 430.23 us |
| multisig-sm-06 | 569.13 us | **290.71 us** | 348.31 us |
| multisig-sm-07 | 584.31 us | **282.23 us** | 344.56 us |
| multisig-sm-08 | 553.01 us | **285.72 us** | 346.91 us |
| multisig-sm-09 | 642.68 us | **286.00 us** | 350.95 us |
| multisig-sm-10 | 774.43 us | **421.17 us** | 422.72 us |
| ping-pong-1 | 311.09 us | **241.31 us** | 284.86 us |
| ping-pong-2 | 248.41 us | **240.19 us** | 282.36 us |
| ping-pong_2-1 | 181.96 us | **144.35 us** | 231.35 us |
| prism-1 | **12.94 us** | 110.71 us | 119.72 us |
| prism-2 | 402.08 us | **299.31 us** | 329.98 us |
| prism-3 | **69.36 us** | 263.97 us | 234.85 us |
| pubkey-1 | **10.72 us** | 96.68 us | 108.32 us |
| stablecoin_1-1 | 4.25 ms | **703.69 us** | 729.15 us |
| stablecoin_1-2 | **36.31 us** | 135.54 us | 135.88 us |
| stablecoin_1-3 | 4.06 ms | **810.25 us** | 815.94 us |
| stablecoin_1-4 | **33.78 us** | 140.22 us | 140.75 us |
| stablecoin_1-5 | 4.00 ms | 1.01 ms | **991.72 us** |
| stablecoin_1-6 | **41.83 us** | 175.02 us | 168.73 us |
| stablecoin_2-1 | 4.22 ms | **722.87 us** | 763.69 us |
| stablecoin_2-2 | **33.91 us** | 135.31 us | 142.91 us |
| stablecoin_2-3 | 4.30 ms | **810.90 us** | 819.05 us |
| stablecoin_2-4 | **34.18 us** | 141.36 us | 141.02 us |
| token-account-1 | **21.79 us** | 135.59 us | 155.54 us |
| token-account-2 | **45.00 us** | 239.13 us | 208.43 us |
| uniswap-1 | **49.78 us** | 317.25 us | 243.78 us |
| uniswap-2 | **36.46 us** | 157.06 us | 169.70 us |
| uniswap-3 | **693.78 us** | 1.20 ms | 927.08 us |
| uniswap-4 | **57.92 us** | 224.75 us | 207.18 us |
| uniswap-5 | 689.11 us | 788.45 us | **666.26 us** |
| uniswap-6 | **53.28 us** | 218.13 us | 199.83 us |
| vesting-1 | **111.83 us** | 254.58 us | 240.69 us |

---
*Generated by [cardano-plutus-vm-benchmark](https://github.com/saib-inc/cardano-plutus-vm-benchmark)*