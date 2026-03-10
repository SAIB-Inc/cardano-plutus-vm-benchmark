# Cardano Plutus VM Benchmark Results

**Date:** 

## Environment
```
date: 2026-03-10T11:45:55+00:00
kernel: 5.15.167.4-microsoft-standard-WSL2
cpu: AMD Ryzen 9 9900X3D 12-Core Processor
cores: 24
memory: 47Gi
```

## Summary (geometric mean across all scripts)

| VM | Language | Geo Mean | vs Fastest |
|---|---|---|---|
| **Plutuz (Zig)** | Zig | 408.04 us | 1.00x |
| **uplc-turbo (Rust)** | Rust | 495.36 us | 1.21x |
| **Chrysalis (C# / .NET JIT)** | C# / .NET JIT | 548.94 us | 1.35x |
| **Chrysalis (C# / .NET AOT)** | C# / .NET AOT | 567.21 us | 1.39x |
| **blaze-plutus (TypeScript / Node V8)** | TypeScript / Node V8 | 1.17 ms | 2.88x |
| **blaze-plutus (TypeScript / Bun JSC)** | TypeScript / Bun JSC | 1.18 ms | 2.89x |
| **Plutigo (Go)** | Go | 2.28 ms | 5.59x |
| **opshin (Python / CPython)** | Python / CPython | 168.95 ms | 414.05x |

## Per-Script Results

| Script | uplc-turbo (Rust) | Plutuz (Zig) | Chrysalis (C# / .NET JIT) | Chrysalis (C# / .NET AOT) | Plutigo (Go) | blaze-plutus (TypeScript / Bun JSC) | blaze-plutus (TypeScript / Node V8) | opshin (Python / CPython) |
|---|---|---|---|---|---|---|---|---|
| auction_1-1 | 259.40 us | **197.25 us** | 260.03 us | 269.68 us | 1.10 ms | 574.10 us | 537.40 us | 93.16 ms |
| auction_1-2 | 789.73 us | **615.99 us** | 873.98 us | 908.35 us | 3.64 ms | 1.82 ms | 1.74 ms | 323.26 ms |
| auction_1-3 | 752.83 us | **601.88 us** | 869.37 us | 899.19 us | 3.66 ms | 1.86 ms | 1.72 ms | 327.06 ms |
| auction_1-4 | 321.99 us | **230.92 us** | 306.96 us | 324.53 us | 1.37 ms | 694.80 us | 670.80 us | 106.70 ms |
| auction_2-1 | 263.47 us | **196.62 us** | 263.40 us | 267.51 us | 1.10 ms | 609.50 us | 529.30 us | 88.15 ms |
| auction_2-2 | 758.33 us | **617.18 us** | 872.82 us | 919.81 us | 3.63 ms | 1.97 ms | 1.73 ms | 323.32 ms |
| auction_2-3 | 945.35 us | **732.14 us** | 1.11 ms | 1.18 ms | 4.65 ms | 2.46 ms | 2.21 ms | 407.34 ms |
| auction_2-4 | 763.26 us | **602.70 us** | 895.83 us | 929.21 us | 3.64 ms | 1.76 ms | 1.75 ms | 326.06 ms |
| auction_2-5 | 312.30 us | **229.62 us** | 317.31 us | 325.07 us | 1.38 ms | 677.40 us | 673.30 us | 108.38 ms |
| crowdfunding-success-1 | 292.86 us | **226.99 us** | 303.47 us | 319.93 us | 1.28 ms | 612.50 us | 613.00 us | 107.52 ms |
| crowdfunding-success-2 | 295.83 us | **232.30 us** | 302.65 us | 316.74 us | 1.29 ms | 615.50 us | 612.80 us | 105.32 ms |
| crowdfunding-success-3 | 289.72 us | **227.74 us** | 302.63 us | 318.66 us | 1.29 ms | 620.00 us | 606.80 us | 105.63 ms |
| currency-1 | 324.14 us | **252.80 us** | 359.43 us | 378.05 us | 1.48 ms | 674.20 us | 656.60 us | 132.01 ms |
| escrow-redeem_1-1 | 436.67 us | **345.91 us** | 492.75 us | 502.42 us | 2.05 ms | 980.60 us | 940.30 us | 179.01 ms |
| escrow-redeem_1-2 | 435.93 us | **344.67 us** | 493.28 us | 504.20 us | 2.04 ms | 945.60 us | 936.40 us | 177.58 ms |
| escrow-redeem_2-1 | 491.99 us | **378.01 us** | 548.66 us | 563.81 us | 2.47 ms | 1.09 ms | 1.07 ms | 199.62 ms |
| escrow-redeem_2-2 | 491.65 us | **383.17 us** | 555.90 us | 565.46 us | 3.18 ms | 1.10 ms | 1.06 ms | 203.87 ms |
| escrow-redeem_2-3 | 492.62 us | **379.81 us** | 548.08 us | 562.48 us | 2.36 ms | 1.07 ms | 1.07 ms | 202.05 ms |
| escrow-refund-1 | 260.20 us | **223.69 us** | 286.67 us | 319.01 us | 1.06 ms | 501.50 us | 500.40 us | 95.45 ms |
| future-increase-margin-1 | 321.47 us | **252.71 us** | 359.43 us | 377.91 us | 1.48 ms | 656.90 us | 646.40 us | 130.54 ms |
| future-increase-margin-2 | 620.99 us | **461.17 us** | 677.52 us | 717.34 us | 3.07 ms | 1.38 ms | 1.37 ms | 258.67 ms |
| future-increase-margin-3 | 620.92 us | **467.94 us** | 686.12 us | 704.89 us | 3.07 ms | 1.38 ms | 1.36 ms | 258.32 ms |
| future-increase-margin-4 | 666.98 us | **585.27 us** | 782.46 us | 847.73 us | 2.97 ms | 1.42 ms | 1.33 ms | - |
| future-increase-margin-5 | 958.03 us | **837.91 us** | 1.14 ms | 1.27 ms | 4.36 ms | 3.54 ms | 3.43 ms | - |
| future-pay-out-1 | 319.91 us | **252.15 us** | 362.73 us | 376.82 us | 1.50 ms | 706.70 us | 671.60 us | 132.69 ms |
| future-pay-out-2 | 615.01 us | **455.65 us** | 690.93 us | 738.15 us | 3.06 ms | 1.43 ms | 1.39 ms | 256.86 ms |
| future-pay-out-3 | 618.37 us | **455.93 us** | 684.88 us | 716.21 us | 3.05 ms | 1.44 ms | 1.42 ms | 260.92 ms |
| future-pay-out-4 | 951.61 us | **835.78 us** | 1.15 ms | 1.18 ms | 4.35 ms | 3.50 ms | 3.39 ms | - |
| future-settle-early-1 | 321.55 us | **255.31 us** | 360.38 us | 375.92 us | 1.48 ms | 688.40 us | 687.80 us | 130.08 ms |
| future-settle-early-2 | 618.58 us | **461.98 us** | 680.68 us | 716.20 us | 3.06 ms | 1.44 ms | 1.42 ms | 256.01 ms |
| future-settle-early-3 | 632.26 us | **456.24 us** | 683.56 us | 697.95 us | 3.07 ms | 1.46 ms | 1.47 ms | 257.59 ms |
| future-settle-early-4 | 777.02 us | **684.04 us** | 935.86 us | 989.04 us | 3.34 ms | 2.97 ms | 3.31 ms | - |
| game-sm-success_1-1 | 526.20 us | **452.56 us** | 623.04 us | 629.11 us | 2.56 ms | 1.24 ms | 1.35 ms | 209.22 ms |
| game-sm-success_1-2 | 275.64 us | **197.13 us** | 268.96 us | 276.17 us | 1.41 ms | 585.20 us | 611.10 us | 93.89 ms |
| game-sm-success_1-3 | 754.31 us | **626.42 us** | 874.94 us | 1.07 ms | 3.64 ms | 1.82 ms | 1.81 ms | 318.24 ms |
| game-sm-success_1-4 | 305.77 us | **225.25 us** | 296.64 us | 303.40 us | 1.39 ms | 668.20 us | 689.50 us | 104.21 ms |
| game-sm-success_2-1 | 531.53 us | **451.26 us** | 603.06 us | 632.66 us | 2.36 ms | 1.20 ms | 1.22 ms | 209.48 ms |
| game-sm-success_2-2 | 267.43 us | **197.49 us** | 264.55 us | 275.58 us | 1.20 ms | 579.50 us | 587.60 us | 92.94 ms |
| game-sm-success_2-3 | 759.43 us | **703.95 us** | 859.12 us | 912.05 us | 3.65 ms | 1.79 ms | 1.82 ms | 321.34 ms |
| game-sm-success_2-4 | 306.96 us | **290.28 us** | 294.87 us | 307.03 us | 1.38 ms | 721.60 us | 681.00 us | 105.77 ms |
| game-sm-success_2-5 | **752.20 us** | 759.02 us | 867.37 us | 917.75 us | 3.67 ms | 1.83 ms | 1.78 ms | 318.56 ms |
| game-sm-success_2-6 | 304.39 us | **239.05 us** | 313.37 us | 309.92 us | 1.38 ms | 685.00 us | 677.80 us | 107.45 ms |
| multisig-sm-1 | 558.89 us | **541.03 us** | 667.88 us | 667.81 us | 2.43 ms | 1.28 ms | 1.26 ms | - |
| multisig-sm-10 | 702.10 us | **609.81 us** | 820.27 us | 852.51 us | 3.25 ms | 1.64 ms | 1.62 ms | - |
| multisig-sm-2 | 545.42 us | **486.72 us** | 625.05 us | 658.71 us | 2.37 ms | 1.24 ms | 1.24 ms | - |
| multisig-sm-3 | 551.14 us | **538.07 us** | 638.60 us | 675.12 us | 2.40 ms | 1.24 ms | 1.32 ms | - |
| multisig-sm-4 | **550.94 us** | 577.59 us | 671.52 us | 670.04 us | 2.47 ms | 1.26 ms | 1.26 ms | - |
| multisig-sm-5 | 703.24 us | **599.22 us** | 828.69 us | 848.14 us | 3.25 ms | 1.63 ms | 1.66 ms | - |
| multisig-sm-6 | 554.27 us | **485.65 us** | 637.18 us | 670.50 us | 2.43 ms | 1.26 ms | 1.31 ms | - |
| multisig-sm-7 | **554.12 us** | 557.19 us | 632.71 us | 661.58 us | 2.38 ms | 1.25 ms | 1.23 ms | - |
| multisig-sm-8 | 556.83 us | **548.47 us** | 647.53 us | 662.38 us | 2.42 ms | 1.25 ms | 1.24 ms | - |
| multisig-sm-9 | 555.77 us | **528.31 us** | 663.60 us | 664.00 us | 2.44 ms | 1.26 ms | 1.26 ms | - |
| ping-pong-1 | 496.79 us | **420.37 us** | 535.69 us | 557.74 us | 2.03 ms | 998.70 us | 1.00 ms | 188.86 ms |
| ping-pong-2 | 462.47 us | **413.92 us** | 558.94 us | 556.28 us | 2.03 ms | 1.00 ms | 1.01 ms | 188.54 ms |
| ping-pong_2-1 | **339.05 us** | 355.71 us | 405.36 us | 429.22 us | 1.40 ms | 696.90 us | 724.30 us | 137.54 ms |
| prism-1 | 226.77 us | **177.01 us** | 236.12 us | 238.64 us | 1.02 ms | 489.60 us | 490.70 us | 82.58 ms |
| prism-2 | 559.89 us | **511.04 us** | 629.18 us | 656.63 us | 2.62 ms | 1.25 ms | 1.20 ms | 235.66 ms |
| prism-3 | 453.84 us | **358.94 us** | 513.51 us | 495.20 us | 2.80 ms | 1.01 ms | 1.01 ms | 208.16 ms |
| pubkey-1 | 201.12 us | **180.59 us** | 221.52 us | 237.01 us | 892.93 us | 420.70 us | 431.30 us | 76.67 ms |
| stablecoin_1-1 | 1.13 ms | **1.10 ms** | 1.35 ms | 1.36 ms | 5.60 ms | 5.20 ms | 5.33 ms | - |
| stablecoin_1-2 | 266.40 us | **197.61 us** | 267.26 us | 274.39 us | 1.29 ms | 570.00 us | 582.40 us | 107.01 ms |
| stablecoin_1-3 | **1.28 ms** | 1.42 ms | 1.51 ms | 1.55 ms | 5.28 ms | 5.61 ms | 5.59 ms | - |
| stablecoin_1-4 | 279.43 us | **253.58 us** | 276.94 us | 282.20 us | 1.26 ms | 601.20 us | 651.90 us | 109.73 ms |
| stablecoin_1-5 | 1.61 ms | **1.54 ms** | 2.10 ms | 2.02 ms | 6.49 ms | 6.54 ms | 6.66 ms | - |
| stablecoin_1-6 | 335.73 us | **248.76 us** | 356.72 us | 328.45 us | 1.52 ms | 731.30 us | 738.90 us | 133.56 ms |
| stablecoin_2-1 | 1.12 ms | **1.08 ms** | 1.42 ms | 1.37 ms | 4.52 ms | 5.13 ms | 5.17 ms | - |
| stablecoin_2-2 | 266.22 us | **197.29 us** | 265.97 us | 283.05 us | 1.20 ms | 578.10 us | 581.20 us | 104.13 ms |
| stablecoin_2-3 | 1.28 ms | **1.14 ms** | 1.51 ms | 1.53 ms | 5.23 ms | 5.59 ms | 5.74 ms | - |
| stablecoin_2-4 | 277.22 us | **204.57 us** | 276.30 us | 281.22 us | 1.26 ms | 612.10 us | 612.40 us | 105.09 ms |
| token-account-1 | 266.15 us | **217.33 us** | 292.86 us | 304.51 us | 1.18 ms | 557.00 us | 561.80 us | 107.36 ms |
| token-account-2 | 402.57 us | **296.83 us** | 467.92 us | 439.50 us | 1.97 ms | 877.70 us | 879.20 us | 163.17 ms |
| uniswap-1 | 461.48 us | **344.00 us** | 547.88 us | 540.03 us | 2.40 ms | 1.04 ms | 1.04 ms | 210.22 ms |
| uniswap-2 | 307.46 us | **245.96 us** | 329.93 us | 344.88 us | 1.37 ms | 659.90 us | 657.80 us | 117.74 ms |
| uniswap-3 | 1.74 ms | **1.37 ms** | 2.01 ms | 2.08 ms | 8.72 ms | 4.97 ms | 4.99 ms | 737.99 ms |
| uniswap-4 | 427.77 us | **294.90 us** | 412.20 us | 416.34 us | 1.97 ms | 966.10 us | 955.30 us | 149.14 ms |
| uniswap-5 | 1.24 ms | **959.90 us** | 1.39 ms | 1.42 ms | 6.04 ms | 3.43 ms | 3.47 ms | 508.69 ms |
| uniswap-6 | 445.85 us | **282.02 us** | 395.04 us | 397.67 us | 1.89 ms | 909.50 us | 933.40 us | 141.31 ms |
| vesting-1 | 431.56 us | **345.30 us** | 493.73 us | 528.05 us | 2.05 ms | 973.00 us | 964.60 us | 183.46 ms |

---
*Generated by [cardano-plutus-vm-benchmark](https://github.com/saib-inc/cardano-plutus-vm-benchmark)*