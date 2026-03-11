# Cardano Plutus VM Benchmark Results

**Date:** 

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
| **plutus-core (Haskell / GHC)** | Haskell / GHC | 195.48 us | 1.67x |
| **Scalus CEK (Scala / JVM)** | Scala / JVM | 275.13 us | 2.35x |
| **Plutuz (Zig)** | Zig | 393.40 us | 3.37x |
| **Chrysalis (C# / .NET AOT)** | C# / .NET AOT | 419.18 us | 3.59x |
| **Chrysalis (C# / .NET JIT)** | C# / .NET JIT | 423.13 us | 3.62x |
| **uplc-turbo (Rust)** | Rust | 435.92 us | 3.73x |
| **blaze-plutus (TypeScript / Node V8)** | TypeScript / Node V8 | 1.24 ms | 10.61x |
| **blaze-plutus (TypeScript / Bun JSC)** | TypeScript / Bun JSC | 1.25 ms | 10.67x |
| **Plutigo (Go)** | Go | 2.31 ms | 19.72x |
| **opshin (Python / CPython)** | Python / CPython | 124.94 ms | 1068.88x |

## Per-Script Results

| Script | plutus-core (Haskell / GHC) | Scalus Hybrid JIT (Scala / JVM) | Scalus CEK (Scala / JVM) | uplc-turbo (Rust) | Plutuz (Zig) | Chrysalis (C# / .NET JIT) | Chrysalis (C# / .NET AOT) | Plutigo (Go) | blaze-plutus (TypeScript / Bun JSC) | blaze-plutus (TypeScript / Node V8) | opshin (Python / CPython) |
|---|---|---|---|---|---|---|---|---|---|---|---|
| auction_1-1 | 87.69 us | **31.84 us** | 122.32 us | 253.04 us | 199.26 us | 196.38 us | 194.00 us | 1.12 ms | 567.10 us | 547.30 us | 91.64 ms |
| auction_1-2 | **325.89 us** | 777.40 us | 498.94 us | 764.87 us | 627.20 us | 698.38 us | 713.65 us | 3.64 ms | 1.83 ms | 1.77 ms | 342.19 ms |
| auction_1-3 | **310.68 us** | 586.83 us | 476.84 us | 777.90 us | 617.12 us | 726.90 us | 701.52 us | 3.64 ms | 1.83 ms | 1.79 ms | 338.62 ms |
| auction_1-4 | 114.60 us | **49.15 us** | 154.56 us | 322.56 us | 234.81 us | 233.66 us | 228.93 us | 1.39 ms | 698.60 us | 697.20 us | 109.81 ms |
| auction_2-1 | 86.51 us | **38.12 us** | 119.18 us | 253.76 us | 200.53 us | 204.09 us | 196.87 us | 1.12 ms | 566.80 us | 551.90 us | 89.42 ms |
| auction_2-2 | **328.29 us** | 1.13 ms | 480.55 us | 776.73 us | 638.45 us | 716.18 us | 720.87 us | 3.66 ms | 1.85 ms | 1.78 ms | 334.33 ms |
| auction_2-3 | **417.89 us** | 828.28 us | 613.21 us | 947.25 us | 754.40 us | 880.52 us | 904.17 us | 4.72 ms | 2.34 ms | 2.26 ms | 428.52 ms |
| auction_2-4 | **314.61 us** | 543.10 us | 466.90 us | 773.14 us | 616.12 us | 698.04 us | 713.02 us | 3.72 ms | 1.85 ms | 1.81 ms | 343.85 ms |
| auction_2-5 | 108.25 us | **43.34 us** | 152.92 us | 315.88 us | 233.90 us | 234.70 us | 240.77 us | 1.39 ms | 707.40 us | 699.80 us | 108.26 ms |
| coop-1 | **112.62 us** | - | - | 117.96 us | 195.64 us | 203.90 us | 204.98 us | 1.48 ms | 761.40 us | 774.50 us | 14.69 ms |
| coop-2 | 366.76 us | - | - | **202.24 us** | 573.70 us | 609.91 us | 620.99 us | 4.46 ms | 2.50 ms | 2.49 ms | 35.30 ms |
| coop-3 | 1.10 ms | - | - | **192.86 us** | 1.43 ms | 1.98 ms | 2.15 ms | 12.09 ms | 6.08 ms | 6.09 ms | 35.24 ms |
| coop-4 | 484.79 us | - | - | **213.27 us** | 695.02 us | 772.00 us | 831.35 us | 5.19 ms | 2.90 ms | 2.98 ms | 39.74 ms |
| coop-5 | 203.60 us | - | - | **192.96 us** | 368.62 us | 383.04 us | 388.88 us | 2.52 ms | 1.34 ms | 1.36 ms | 38.24 ms |
| coop-6 | 332.56 us | - | - | **147.51 us** | 499.28 us | 520.72 us | 539.63 us | 4.12 ms | 2.13 ms | 2.19 ms | 17.97 ms |
| coop-7 | 155.87 us | - | - | **123.15 us** | 269.24 us | 270.26 us | 280.72 us | 2.09 ms | 1.05 ms | 1.07 ms | 17.27 ms |
| crowdfunding-success-1 | 104.05 us | **32.13 us** | 140.35 us | 293.24 us | 236.28 us | 231.51 us | 225.70 us | 1.31 ms | 636.60 us | 659.00 us | 109.95 ms |
| crowdfunding-success-2 | 103.99 us | **33.57 us** | 140.31 us | 292.46 us | 236.92 us | 230.54 us | 222.53 us | 1.30 ms | 635.50 us | 664.00 us | 113.07 ms |
| crowdfunding-success-3 | 101.67 us | **32.05 us** | 139.28 us | 299.38 us | 232.91 us | 239.29 us | 230.28 us | 1.31 ms | 634.80 us | 659.90 us | 110.11 ms |
| currency-1 | 123.17 us | **29.62 us** | 221.14 us | 323.09 us | 258.78 us | 286.22 us | 279.27 us | 1.52 ms | 709.70 us | 708.00 us | 134.88 ms |
| escrow-redeem_1-1 | 178.37 us | **62.12 us** | 245.38 us | 457.32 us | 352.18 us | 393.36 us | 377.60 us | 2.10 ms | 986.70 us | 1.03 ms | 179.49 ms |
| escrow-redeem_1-2 | 174.44 us | **61.50 us** | 247.28 us | 448.64 us | 356.25 us | 376.38 us | 385.06 us | 2.07 ms | 989.90 us | 1.02 ms | 182.20 ms |
| escrow-redeem_2-1 | 201.25 us | **71.29 us** | 288.25 us | 506.08 us | 388.32 us | 426.12 us | 423.86 us | 2.38 ms | 1.13 ms | 1.16 ms | 210.10 ms |
| escrow-redeem_2-2 | 205.65 us | **70.49 us** | 293.48 us | 502.17 us | 388.82 us | 425.81 us | 423.59 us | 2.40 ms | 1.13 ms | 1.17 ms | 210.87 ms |
| escrow-redeem_2-3 | 207.42 us | **67.40 us** | 297.99 us | 502.21 us | 390.79 us | 430.79 us | 417.62 us | 2.42 ms | 1.13 ms | 1.15 ms | 209.53 ms |
| escrow-refund-1 | 80.62 us | **15.84 us** | 104.08 us | 268.48 us | 227.33 us | 215.95 us | 205.83 us | 1.08 ms | 525.40 us | 545.00 us | 100.81 ms |
| future-increase-margin-1 | 126.21 us | **27.36 us** | 177.74 us | 322.49 us | 257.13 us | 289.52 us | 286.62 us | 1.52 ms | 693.10 us | 695.10 us | 140.49 ms |
| future-increase-margin-2 | 264.26 us | **99.11 us** | 394.35 us | 646.67 us | 466.24 us | 535.49 us | 541.69 us | 3.11 ms | 1.45 ms | 1.49 ms | 268.71 ms |
| future-increase-margin-3 | 307.55 us | **112.73 us** | 411.28 us | 632.53 us | 470.90 us | 533.98 us | 547.39 us | 3.10 ms | 1.46 ms | 1.47 ms | 263.51 ms |
| future-increase-margin-4 | **276.75 us** | 614.19 us | 362.42 us | 683.84 us | 593.25 us | 617.74 us | 617.16 us | 3.02 ms | 1.45 ms | 1.46 ms | FAIL |
| future-increase-margin-5 | **497.16 us** | 1.23 ms | 635.38 us | 990.29 us | 856.70 us | 959.43 us | 927.43 us | 4.46 ms | 3.63 ms | 3.54 ms | FAIL |
| future-pay-out-1 | 139.83 us | **32.03 us** | 175.67 us | 320.68 us | 257.44 us | 289.68 us | 290.35 us | 1.50 ms | 725.80 us | 713.60 us | 134.94 ms |
| future-pay-out-2 | 274.75 us | **114.93 us** | 391.56 us | 633.50 us | 462.79 us | 563.30 us | 540.19 us | 3.08 ms | 1.53 ms | 1.49 ms | 267.48 ms |
| future-pay-out-3 | 288.63 us | **97.65 us** | 391.02 us | 622.75 us | 465.64 us | 538.64 us | 542.76 us | 3.09 ms | 1.58 ms | 1.50 ms | 266.55 ms |
| future-pay-out-4 | **443.42 us** | 1.36 ms | 623.85 us | 980.84 us | 850.50 us | 944.59 us | 968.04 us | 4.48 ms | 3.65 ms | 3.55 ms | FAIL |
| future-settle-early-1 | 140.75 us | **27.51 us** | 182.01 us | 319.99 us | 260.17 us | 284.00 us | 284.14 us | 1.52 ms | 748.60 us | 724.20 us | 134.82 ms |
| future-settle-early-2 | 273.91 us | **105.01 us** | 388.29 us | 629.63 us | 470.93 us | 548.95 us | 549.61 us | 3.12 ms | 1.54 ms | 1.50 ms | 263.74 ms |
| future-settle-early-3 | 266.81 us | **93.96 us** | 388.50 us | 632.67 us | 467.91 us | 545.91 us | 530.07 us | 3.10 ms | 1.53 ms | 1.50 ms | 268.20 ms |
| future-settle-early-4 | **341.14 us** | 1.16 ms | 476.15 us | 772.69 us | 690.61 us | 738.26 us | 730.30 us | 3.40 ms | 3.08 ms | 3.01 ms | FAIL |
| game-sm-success_1-1 | **222.38 us** | 407.09 us | 274.51 us | 539.18 us | 457.52 us | 480.43 us | 463.80 us | 2.40 ms | 1.30 ms | 1.25 ms | 220.46 ms |
| game-sm-success_1-2 | 103.94 us | **31.63 us** | 135.26 us | 269.89 us | 200.23 us | 204.10 us | 202.71 us | 1.22 ms | 673.60 us | 598.00 us | 98.39 ms |
| game-sm-success_1-3 | **359.94 us** | 525.66 us | 479.31 us | 768.73 us | 618.67 us | 702.62 us | 703.00 us | 3.71 ms | 2.10 ms | 1.88 ms | 326.14 ms |
| game-sm-success_1-4 | 116.38 us | **36.13 us** | 155.79 us | 308.38 us | 225.38 us | 231.71 us | 227.60 us | 1.40 ms | 732.50 us | 704.30 us | 108.50 ms |
| game-sm-success_2-1 | **200.30 us** | 431.62 us | 273.54 us | 540.25 us | 470.20 us | 480.65 us | 456.88 us | 2.39 ms | 1.26 ms | 1.25 ms | 219.88 ms |
| game-sm-success_2-2 | 97.41 us | **32.44 us** | 137.19 us | 267.76 us | 205.22 us | 204.24 us | 198.30 us | 1.23 ms | 615.90 us | 601.10 us | 97.33 ms |
| game-sm-success_2-3 | **322.11 us** | 557.04 us | 464.18 us | 767.78 us | 625.27 us | 717.34 us | 710.58 us | 3.72 ms | 1.93 ms | 1.86 ms | 332.62 ms |
| game-sm-success_2-4 | 110.58 us | **36.65 us** | 155.38 us | 305.23 us | 222.06 us | 228.09 us | 225.95 us | 1.39 ms | 723.20 us | 708.70 us | 108.70 ms |
| game-sm-success_2-5 | **313.31 us** | 564.59 us | 492.07 us | 769.31 us | 628.82 us | 726.10 us | 688.40 us | 3.76 ms | 1.91 ms | 1.89 ms | 331.15 ms |
| game-sm-success_2-6 | 112.25 us | **36.99 us** | 157.66 us | 309.83 us | 226.89 us | 229.69 us | 226.88 us | 1.42 ms | 727.70 us | 737.00 us | 107.57 ms |
| guardrail-sorted-large | **216.03 us** | - | - | 218.18 us | 322.03 us | 404.08 us | 422.00 us | 2.85 ms | 1.53 ms | 1.44 ms | 19.63 ms |
| guardrail-sorted-small | **32.96 us** | - | - | 111.96 us | 93.82 us | 102.83 us | 97.83 us | 476.36 us | 278.30 us | 264.00 us | 15.35 ms |
| guardrail-unsorted-large | 294.51 us | - | - | **198.38 us** | 418.87 us | 544.70 us | 579.19 us | 3.69 ms | 2.03 ms | 1.91 ms | 19.69 ms |
| guardrail-unsorted-small | **32.80 us** | - | - | 109.79 us | 93.54 us | 97.39 us | 97.50 us | 465.95 us | 272.00 us | 259.90 us | 15.63 ms |
| multisig-sm-01 | **203.38 us** | 502.24 us | 281.13 us | 560.85 us | 503.51 us | 508.72 us | 492.43 us | 2.48 ms | 1.34 ms | 1.31 ms | FAIL |
| multisig-sm-02 | **245.79 us** | 539.76 us | 279.12 us | 557.56 us | 494.49 us | 492.60 us | 481.05 us | 2.44 ms | 1.31 ms | 1.29 ms | FAIL |
| multisig-sm-03 | **200.34 us** | 559.21 us | 300.96 us | 558.46 us | 492.81 us | 501.49 us | 484.53 us | 2.46 ms | 1.33 ms | 1.32 ms | FAIL |
| multisig-sm-04 | **201.49 us** | 512.92 us | 290.44 us | 558.23 us | 502.34 us | 518.91 us | 502.79 us | 2.44 ms | 1.34 ms | 1.40 ms | FAIL |
| multisig-sm-05 | **288.36 us** | 756.37 us | 414.28 us | 724.51 us | 610.88 us | 680.63 us | 648.21 us | 3.30 ms | 1.75 ms | 1.91 ms | FAIL |
| multisig-sm-06 | **207.34 us** | 530.58 us | 283.94 us | 570.53 us | 508.67 us | 532.16 us | 493.10 us | 2.47 ms | 1.34 ms | 1.52 ms | FAIL |
| multisig-sm-07 | **203.94 us** | 552.52 us | 280.50 us | 555.90 us | 492.92 us | 511.52 us | 491.50 us | 2.48 ms | 1.31 ms | 1.30 ms | FAIL |
| multisig-sm-08 | **201.51 us** | 549.47 us | 285.88 us | 552.54 us | 495.90 us | 495.63 us | 492.88 us | 2.47 ms | 1.31 ms | 1.34 ms | FAIL |
| multisig-sm-09 | **204.33 us** | 505.65 us | 287.88 us | 572.90 us | 491.07 us | 503.12 us | 497.13 us | 2.47 ms | 1.31 ms | 1.34 ms | FAIL |
| multisig-sm-10 | **285.61 us** | 723.89 us | 410.14 us | 723.06 us | 593.85 us | 663.77 us | 647.39 us | 3.28 ms | 1.73 ms | 1.75 ms | FAIL |
| ping-pong-1 | **168.72 us** | 231.53 us | 253.18 us | 473.71 us | 420.25 us | 413.33 us | 417.88 us | 2.07 ms | 1.09 ms | 1.09 ms | 194.66 ms |
| ping-pong-2 | **165.57 us** | 223.28 us | 243.64 us | 464.79 us | 417.80 us | 431.62 us | 415.82 us | 2.08 ms | 1.10 ms | 1.11 ms | 194.59 ms |
| ping-pong_2-1 | 102.33 us | **85.34 us** | 146.92 us | 345.77 us | 321.57 us | 314.87 us | 288.69 us | 1.44 ms | 764.90 us | 774.70 us | 141.05 ms |
| prism-1 | 80.72 us | **13.37 us** | 112.22 us | 237.60 us | 178.05 us | 176.49 us | 170.96 us | 1.03 ms | 533.40 us | 537.60 us | 85.31 ms |
| prism-2 | **207.42 us** | 405.46 us | 287.33 us | 571.41 us | 487.71 us | 490.94 us | 489.38 us | 2.54 ms | 1.30 ms | 1.26 ms | 228.79 ms |
| prism-3 | 186.10 us | **68.35 us** | 268.53 us | 470.63 us | 344.46 us | 376.95 us | 385.83 us | 2.16 ms | 1.07 ms | 1.05 ms | 178.02 ms |
| pubkey-1 | 69.26 us | **11.77 us** | 104.08 us | 204.47 us | 159.96 us | 158.65 us | 157.85 us | 918.32 us | 454.80 us | 444.10 us | 72.74 ms |
| stablecoin_1-1 | **501.80 us** | - | 707.21 us | 1.17 ms | 1.03 ms | 1.11 ms | 1.09 ms | 4.69 ms | 5.35 ms | 5.55 ms | FAIL |
| stablecoin_1-2 | 93.82 us | **31.58 us** | 132.28 us | 269.19 us | 199.25 us | 206.98 us | 200.57 us | 1.22 ms | 604.50 us | 608.70 us | 94.27 ms |
| stablecoin_1-3 | **553.69 us** | - | 796.45 us | 1.31 ms | 1.15 ms | 1.24 ms | 1.22 ms | 5.21 ms | 5.77 ms | 5.84 ms | FAIL |
| stablecoin_1-4 | 102.08 us | **34.05 us** | 141.55 us | 285.85 us | 208.89 us | 213.51 us | 209.54 us | 1.27 ms | 634.90 us | 641.00 us | 99.77 ms |
| stablecoin_1-5 | **713.00 us** | - | 1.01 ms | 1.65 ms | 1.43 ms | 1.55 ms | 1.51 ms | 6.66 ms | 6.79 ms | 6.81 ms | FAIL |
| stablecoin_1-6 | 122.35 us | **41.08 us** | 170.90 us | 333.26 us | 242.90 us | 248.26 us | 247.64 us | 1.56 ms | 763.90 us | 773.00 us | 122.16 ms |
| stablecoin_2-1 | **493.64 us** | - | 697.40 us | 1.16 ms | 1.05 ms | 1.11 ms | 1.11 ms | 4.60 ms | 5.29 ms | 5.38 ms | FAIL |
| stablecoin_2-2 | 96.69 us | **32.37 us** | 134.06 us | 273.51 us | 201.01 us | 197.10 us | 198.89 us | 1.21 ms | 605.90 us | 611.00 us | 96.44 ms |
| stablecoin_2-3 | **556.60 us** | - | 790.75 us | 1.30 ms | 1.14 ms | 1.22 ms | 1.22 ms | 5.25 ms | 5.80 ms | 5.80 ms | FAIL |
| stablecoin_2-4 | 99.27 us | **32.82 us** | 139.62 us | 284.81 us | 206.39 us | 213.13 us | 207.65 us | 1.29 ms | 641.20 us | 648.60 us | 103.32 ms |
| token-account-1 | 93.56 us | **23.06 us** | 134.52 us | 267.77 us | 217.82 us | 237.99 us | 233.37 us | 1.19 ms | 581.70 us | 582.20 us | 109.58 ms |
| token-account-2 | 162.22 us | **40.11 us** | 242.30 us | 412.03 us | 300.23 us | 348.53 us | 344.61 us | 2.01 ms | 916.00 us | 897.10 us | 170.27 ms |
| uniswap-1 | 196.25 us | **43.09 us** | 319.01 us | 466.10 us | 351.54 us | 434.97 us | 441.40 us | 2.49 ms | 1.12 ms | 1.07 ms | 218.83 ms |
| uniswap-2 | 108.66 us | **32.99 us** | 157.25 us | 310.97 us | 245.75 us | 258.94 us | 257.42 us | 1.40 ms | 691.00 us | 674.70 us | 121.50 ms |
| uniswap-3 | **867.12 us** | - | 1.19 ms | 1.77 ms | 1.39 ms | 1.63 ms | 1.67 ms | 8.97 ms | 5.20 ms | 5.03 ms | 757.84 ms |
| uniswap-4 | 159.26 us | **55.95 us** | 224.31 us | 439.69 us | 300.58 us | 314.88 us | 304.17 us | 2.01 ms | 1.00 ms | 993.90 us | 147.94 ms |
| uniswap-5 | **570.76 us** | - | 759.10 us | 1.29 ms | 973.83 us | 1.11 ms | 1.11 ms | 6.07 ms | 3.57 ms | 3.46 ms | 516.95 ms |
| uniswap-6 | 152.09 us | **53.60 us** | 215.53 us | 408.90 us | 285.46 us | 303.67 us | 303.17 us | 1.91 ms | 952.50 us | 936.20 us | 145.85 ms |
| vesting-1 | 173.47 us | **80.64 us** | 249.63 us | 441.15 us | 350.02 us | 410.40 us | 400.62 us | 2.09 ms | 1.01 ms | 980.40 us | 187.12 ms |

---
*Generated by [cardano-plutus-vm-benchmark](https://github.com/saib-inc/cardano-plutus-vm-benchmark)*