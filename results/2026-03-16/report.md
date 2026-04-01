# Cardano Plutus VM Benchmark Results

**Date:** 

## Environment
```
date: 2026-03-16T12:41:38+00:00
kernel: 5.15.167.4-microsoft-standard-WSL2
cpu: AMD Ryzen 9 9900X3D 12-Core Processor
cores: 24
memory: 47Gi
```

## Summary (geometric mean across all scripts)

*Note: VMs that fail or skip a script are assigned the slowest competitor's time for that script.*

| VM | Language | Geo Mean | vs Fastest |
|---|---|---|---|
| **plutus-core (Haskell / GHC)** | Haskell / GHC | 191.95 us | 1.00x |
| **uplc-turbo Bytecode (Rust / AOT)** | Rust / AOT | 223.66 us | 1.17x |
| **uplc-turbo AST (Rust)** | Rust | 290.96 us | 1.52x |
| **Plutuz (Zig)** | Zig | 395.36 us | 2.06x |
| **Scalus Hybrid JIT (Scala / JVM)** | Scala / JVM | 406.95 us | 2.12x |
| **Chrysalis (C# / .NET AOT)** | C# / .NET AOT | 409.91 us | 2.14x |
| **Chrysalis (C# / .NET JIT)** | C# / .NET JIT | 416.47 us | 2.17x |
| **Scalus CEK (Scala / JVM)** | Scala / JVM | 510.42 us | 2.66x |
| **blaze-plutus (TypeScript / Bun JSC)** | TypeScript / Bun JSC | 1.31 ms | 6.80x |
| **blaze-plutus (TypeScript / Node V8)** | TypeScript / Node V8 | 1.32 ms | 6.88x |
| **Plutigo (Go)** | Go | 1.65 ms | 8.59x |
| **opshin (Python / CPython)** | Python / CPython | 56.65 ms | 295.11x |

### Script Coverage

| VM | Passed | Failed | Missing | Total |
|---|---|---|---|---|
| plutus-core (Haskell / GHC) | 89 | 0 | 0 | 89 |
| uplc-turbo Bytecode (Rust / AOT) | 89 | 0 | 0 | 89 |
| uplc-turbo AST (Rust) | 89 | 0 | 0 | 89 |
| Plutuz (Zig) | 89 | 0 | 0 | 89 |
| Scalus Hybrid JIT (Scala / JVM) | 71 | 18 | 0 | 89 |
| Chrysalis (C# / .NET AOT) | 89 | 0 | 0 | 89 |
| Chrysalis (C# / .NET JIT) | 89 | 0 | 0 | 89 |
| Scalus CEK (Scala / JVM) | 78 | 11 | 0 | 89 |
| blaze-plutus (TypeScript / Bun JSC) | 89 | 0 | 0 | 89 |
| blaze-plutus (TypeScript / Node V8) | 89 | 0 | 0 | 89 |
| Plutigo (Go) | 89 | 0 | 0 | 89 |
| opshin (Python / CPython) | 70 | 19 | 0 | 89 |

## Per-Script Results

| Script | plutus-core (Haskell / GHC) | Scalus Hybrid JIT (Scala / JVM) | Scalus CEK (Scala / JVM) | uplc-turbo Bytecode (Rust / AOT) | uplc-turbo AST (Rust) | Plutuz (Zig) | Chrysalis (C# / .NET JIT) | Chrysalis (C# / .NET AOT) | Plutigo (Go) | blaze-plutus (TypeScript / Bun JSC) | blaze-plutus (TypeScript / Node V8) | opshin (Python / CPython) |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| auction_1-1 | 85.04 us | **36.62 us** | 131.34 us | 109.74 us | 155.54 us | 202.53 us | 196.17 us | 195.41 us | 789.86 us | 592.00 us | 580.40 us | 91.39 ms |
| auction_1-2 | **327.45 us** | 969.14 us | 514.61 us | 365.29 us | 431.24 us | 634.34 us | 703.57 us | 699.38 us | 2.62 ms | 1.96 ms | 1.95 ms | 342.72 ms |
| auction_1-3 | **321.65 us** | 748.58 us | 514.91 us | 348.33 us | 425.81 us | 615.94 us | 692.23 us | 702.84 us | 2.61 ms | 1.94 ms | 1.98 ms | 338.08 ms |
| auction_1-4 | 110.12 us | **43.92 us** | 167.25 us | 139.15 us | 184.31 us | 231.81 us | 234.23 us | 224.90 us | 1.01 ms | 719.70 us | 739.70 us | 108.65 ms |
| auction_2-1 | 88.44 us | **34.06 us** | 131.20 us | 108.43 us | 152.40 us | 198.35 us | 201.11 us | 193.16 us | 793.77 us | 574.40 us | 586.50 us | 92.06 ms |
| auction_2-2 | **321.83 us** | 1.08 ms | 528.34 us | 353.21 us | 432.48 us | 629.92 us | 699.72 us | 685.83 us | 2.61 ms | 1.84 ms | 1.99 ms | 338.17 ms |
| auction_2-3 | **421.38 us** | 1.04 ms | 684.65 us | 436.47 us | 515.63 us | 750.95 us | 864.58 us | 866.35 us | 3.31 ms | 2.37 ms | 2.42 ms | 421.70 ms |
| auction_2-4 | **311.29 us** | 727.77 us | 516.40 us | 352.43 us | 435.59 us | 616.46 us | 694.06 us | 696.74 us | 2.63 ms | 1.85 ms | 1.93 ms | 337.43 ms |
| auction_2-5 | 110.12 us | **50.41 us** | 167.60 us | 143.16 us | 184.09 us | 239.46 us | 233.19 us | 226.14 us | 1.01 ms | 713.60 us | 723.30 us | 109.16 ms |
| coop-1 | **111.58 us** | FAIL | FAIL | 143.77 us | 163.78 us | 199.57 us | 201.70 us | 205.37 us | 1.05 ms | 791.70 us | 781.80 us | 15.00 ms |
| coop-2 | **365.11 us** | FAIL | FAIL | 485.93 us | 512.10 us | 575.94 us | 592.05 us | 602.64 us | 3.08 ms | 2.64 ms | 2.63 ms | 36.37 ms |
| coop-3 | 1.11 ms | FAIL | FAIL | 1.29 ms | **1.09 ms** | 1.42 ms | 1.94 ms | 2.01 ms | 7.93 ms | 6.30 ms | 6.31 ms | 35.78 ms |
| coop-4 | **480.51 us** | FAIL | FAIL | 528.86 us | 541.23 us | 696.22 us | 763.15 us | 764.72 us | 3.58 ms | 3.29 ms | 3.12 ms | 39.90 ms |
| coop-5 | **198.26 us** | FAIL | FAIL | 246.49 us | 302.48 us | 374.89 us | 383.06 us | 386.12 us | 1.80 ms | 1.38 ms | 1.49 ms | 40.32 ms |
| coop-6 | **360.37 us** | FAIL | FAIL | 446.61 us | 458.28 us | 501.42 us | 525.01 us | 531.89 us | 2.81 ms | 2.27 ms | 2.32 ms | 18.24 ms |
| coop-7 | **155.13 us** | FAIL | FAIL | 200.87 us | 228.78 us | 274.24 us | 276.30 us | 269.26 us | 1.48 ms | 1.10 ms | 1.21 ms | 17.33 ms |
| crowdfunding-success-1 | 103.88 us | **37.12 us** | 151.98 us | 126.94 us | 181.84 us | 236.27 us | 229.05 us | 220.42 us | 942.41 us | 690.00 us | 700.90 us | 108.83 ms |
| crowdfunding-success-2 | 103.70 us | **37.16 us** | 149.19 us | 125.95 us | 181.05 us | 232.81 us | 226.50 us | 220.62 us | 943.76 us | 715.60 us | 720.00 us | 113.72 ms |
| crowdfunding-success-3 | 102.81 us | **38.75 us** | 151.78 us | 128.74 us | 181.53 us | 230.82 us | 228.84 us | 218.34 us | 940.43 us | 870.70 us | 703.00 us | 124.07 ms |
| currency-1 | 124.09 us | **36.91 us** | 199.84 us | 144.21 us | 187.73 us | 262.49 us | 288.78 us | 276.76 us | 1.08 ms | 735.90 us | 754.90 us | 138.35 ms |
| escrow-redeem_1-1 | 173.59 us | **102.65 us** | 269.97 us | 198.57 us | 259.98 us | 368.67 us | 376.25 us | 390.59 us | 1.50 ms | 1.07 ms | 1.06 ms | 185.83 ms |
| escrow-redeem_1-2 | 174.23 us | **71.47 us** | 269.17 us | 198.41 us | 259.70 us | 358.64 us | 379.22 us | 371.52 us | 1.49 ms | 1.06 ms | 1.06 ms | 185.65 ms |
| escrow-redeem_2-1 | 201.01 us | **81.63 us** | 318.58 us | 231.12 us | 288.85 us | 389.22 us | 428.03 us | 410.11 us | 1.70 ms | 1.21 ms | 1.24 ms | 211.76 ms |
| escrow-redeem_2-2 | 201.03 us | **103.59 us** | 310.93 us | 233.06 us | 295.34 us | 386.79 us | 429.77 us | 423.00 us | 1.71 ms | 1.21 ms | 1.20 ms | 208.31 ms |
| escrow-redeem_2-3 | 204.21 us | **87.22 us** | 316.81 us | 229.41 us | 289.66 us | 394.33 us | 431.96 us | 425.70 us | 1.69 ms | 1.21 ms | 1.33 ms | 220.34 ms |
| escrow-refund-1 | 75.23 us | **19.34 us** | 118.07 us | 94.03 us | 165.19 us | 225.99 us | 213.82 us | 203.05 us | 800.97 us | 590.50 us | 559.70 us | 100.20 ms |
| future-increase-margin-1 | 124.00 us | **37.85 us** | 199.82 us | 146.25 us | 189.20 us | 255.72 us | 285.51 us | 275.85 us | 1.09 ms | 756.60 us | 732.90 us | 137.72 ms |
| future-increase-margin-2 | 263.27 us | **127.43 us** | 433.15 us | 299.03 us | 353.07 us | 468.62 us | 532.56 us | 529.64 us | 2.19 ms | 1.58 ms | 1.58 ms | 267.49 ms |
| future-increase-margin-3 | 267.98 us | **119.03 us** | 416.92 us | 300.02 us | 363.34 us | 469.38 us | 531.89 us | 529.71 us | 2.18 ms | 1.57 ms | 1.58 ms | 282.91 ms |
| future-increase-margin-4 | **246.97 us** | 806.73 us | 388.63 us | 271.65 us | 400.59 us | 602.11 us | 604.91 us | 592.94 us | 2.20 ms | 1.55 ms | 1.55 ms | FAIL |
| future-increase-margin-5 | **424.97 us** | 2.27 ms | 706.10 us | 441.72 us | 568.24 us | 873.91 us | 923.94 us | 913.41 us | 3.14 ms | 3.85 ms | 3.91 ms | FAIL |
| future-pay-out-1 | 122.86 us | **44.80 us** | 192.92 us | 144.34 us | 196.88 us | 260.43 us | 282.84 us | 280.53 us | 1.09 ms | 772.70 us | 813.70 us | 135.94 ms |
| future-pay-out-2 | 269.88 us | **119.54 us** | 433.37 us | 305.92 us | 363.71 us | 462.33 us | 534.65 us | 523.88 us | 2.18 ms | 1.55 ms | 1.60 ms | 265.57 ms |
| future-pay-out-3 | 263.11 us | **127.51 us** | 419.85 us | 302.16 us | 355.73 us | 468.11 us | 546.20 us | 526.21 us | 2.20 ms | 1.68 ms | 1.62 ms | 270.85 ms |
| future-pay-out-4 | **424.33 us** | 1.57 ms | 688.67 us | 441.95 us | 553.45 us | 877.21 us | 937.26 us | 941.52 us | 3.16 ms | 3.73 ms | 3.89 ms | FAIL |
| future-settle-early-1 | 123.99 us | **39.48 us** | 199.81 us | 142.89 us | 187.42 us | 267.55 us | 281.79 us | 283.09 us | 1.08 ms | 728.70 us | 749.90 us | 142.07 ms |
| future-settle-early-2 | 257.96 us | **135.22 us** | 417.36 us | 312.36 us | 352.31 us | 473.36 us | 549.32 us | 536.93 us | 2.21 ms | 1.62 ms | 1.59 ms | 270.07 ms |
| future-settle-early-3 | 273.37 us | **122.04 us** | 424.89 us | 300.87 us | 363.17 us | 465.87 us | 532.07 us | 525.82 us | 2.19 ms | 1.54 ms | 1.57 ms | 264.74 ms |
| future-settle-early-4 | **317.53 us** | 1.53 ms | 519.87 us | 343.66 us | 477.95 us | 707.88 us | 739.29 us | 731.70 us | 2.45 ms | 3.24 ms | 3.23 ms | FAIL |
| game-sm-success_1-1 | **198.51 us** | 486.54 us | 292.43 us | 223.11 us | 323.17 us | 472.28 us | 469.85 us | 459.06 us | 1.75 ms | 1.38 ms | 1.36 ms | 219.42 ms |
| game-sm-success_1-2 | 95.96 us | **34.02 us** | 145.68 us | 121.94 us | 158.28 us | 201.39 us | 201.46 us | 196.69 us | 862.88 us | 620.30 us | 620.80 us | 96.22 ms |
| game-sm-success_1-3 | **323.10 us** | 630.87 us | 513.57 us | 351.07 us | 439.69 us | 643.14 us | 689.91 us | 672.75 us | 2.63 ms | 1.97 ms | 2.02 ms | 359.60 ms |
| game-sm-success_1-4 | 112.58 us | **40.87 us** | 173.89 us | 141.75 us | 178.85 us | 222.08 us | 224.09 us | 218.89 us | 1.00 ms | 720.60 us | 737.10 us | 108.33 ms |
| game-sm-success_2-1 | **203.69 us** | 459.60 us | 294.56 us | 220.07 us | 321.03 us | 463.48 us | 467.33 us | 453.86 us | 1.75 ms | 1.32 ms | 1.35 ms | 218.52 ms |
| game-sm-success_2-2 | 95.07 us | **36.62 us** | 148.13 us | 123.12 us | 162.69 us | 207.40 us | 203.99 us | 199.31 us | 870.89 us | 623.20 us | 617.50 us | 96.35 ms |
| game-sm-success_2-3 | **312.98 us** | 669.71 us | 510.34 us | 348.86 us | 432.38 us | 638.09 us | 682.00 us | 680.50 us | 2.62 ms | 1.96 ms | 2.06 ms | 333.44 ms |
| game-sm-success_2-4 | 112.41 us | **39.27 us** | 169.34 us | 142.38 us | 180.87 us | 222.43 us | 223.62 us | 221.95 us | 1.00 ms | 730.90 us | 759.70 us | 112.29 ms |
| game-sm-success_2-5 | **315.33 us** | 627.06 us | 519.87 us | 355.65 us | 437.26 us | 614.53 us | 689.38 us | 674.40 us | 2.68 ms | 1.98 ms | 2.07 ms | 333.83 ms |
| game-sm-success_2-6 | 111.35 us | **41.99 us** | 169.91 us | 144.16 us | 176.98 us | 220.84 us | 222.77 us | 219.01 us | 992.69 us | 732.00 us | 756.60 us | 110.84 ms |
| guardrail-sorted-large | **213.56 us** | FAIL | FAIL | 266.83 us | 326.85 us | 316.58 us | 394.81 us | 418.66 us | 2.12 ms | 1.53 ms | 1.60 ms | 20.56 ms |
| guardrail-sorted-small | **32.27 us** | FAIL | FAIL | 43.26 us | 72.73 us | 92.67 us | 97.86 us | 95.68 us | 351.62 us | 268.50 us | 269.90 us | 16.06 ms |
| guardrail-unsorted-large | **296.19 us** | FAIL | FAIL | 349.66 us | 383.81 us | 417.43 us | 542.72 us | 552.20 us | 2.63 ms | 1.89 ms | 2.09 ms | 20.54 ms |
| guardrail-unsorted-small | **33.33 us** | FAIL | FAIL | 42.86 us | 72.92 us | 92.32 us | 94.11 us | 95.48 us | 348.32 us | 269.60 us | 276.60 us | 15.85 ms |
| multisig-sm-01 | **204.86 us** | 620.02 us | 311.07 us | 224.13 us | 337.35 us | 502.02 us | 512.04 us | 484.85 us | 1.80 ms | 1.43 ms | 1.42 ms | FAIL |
| multisig-sm-02 | **201.47 us** | 617.10 us | 306.01 us | 221.59 us | 342.63 us | 493.02 us | 489.87 us | 472.54 us | 1.77 ms | 1.38 ms | 1.36 ms | FAIL |
| multisig-sm-03 | **194.48 us** | 679.54 us | 311.82 us | 223.52 us | 340.89 us | 490.16 us | 502.95 us | 484.85 us | 1.78 ms | 1.38 ms | 1.40 ms | FAIL |
| multisig-sm-04 | **203.63 us** | 676.26 us | 315.78 us | 225.01 us | 337.90 us | 499.12 us | 495.01 us | 488.85 us | 1.83 ms | 1.40 ms | 1.43 ms | FAIL |
| multisig-sm-05 | **287.33 us** | 889.75 us | 456.39 us | 308.18 us | 403.45 us | 615.22 us | 645.00 us | 629.15 us | 2.44 ms | 1.89 ms | 1.83 ms | FAIL |
| multisig-sm-06 | **208.51 us** | 580.37 us | 309.65 us | 230.70 us | 334.41 us | 505.94 us | 532.50 us | 486.88 us | 1.83 ms | 1.41 ms | 1.42 ms | FAIL |
| multisig-sm-07 | **204.57 us** | 668.74 us | 306.60 us | 220.63 us | 331.32 us | 500.61 us | 501.05 us | 479.95 us | 1.78 ms | 1.36 ms | 1.39 ms | FAIL |
| multisig-sm-08 | **200.16 us** | 640.26 us | 315.90 us | 225.01 us | 338.53 us | 500.64 us | 493.12 us | 481.57 us | 1.80 ms | 1.36 ms | 1.43 ms | FAIL |
| multisig-sm-09 | **200.97 us** | 676.38 us | 305.86 us | 226.92 us | 340.08 us | 502.37 us | 494.54 us | 506.04 us | 1.82 ms | 1.38 ms | 1.44 ms | FAIL |
| multisig-sm-10 | **279.05 us** | 919.17 us | 454.10 us | 314.31 us | 409.43 us | 596.55 us | 663.19 us | 647.30 us | 2.43 ms | 1.81 ms | 1.87 ms | FAIL |
| ping-pong-1 | **167.90 us** | 361.32 us | 260.56 us | 188.80 us | 286.24 us | 408.62 us | 407.97 us | 410.87 us | 1.54 ms | 1.13 ms | 1.16 ms | 194.00 ms |
| ping-pong-2 | **167.31 us** | 366.35 us | 254.84 us | 189.42 us | 282.23 us | 408.32 us | 418.01 us | 414.02 us | 1.53 ms | 1.17 ms | 1.21 ms | 199.48 ms |
| ping-pong_2-1 | **101.82 us** | 149.60 us | 152.51 us | 118.60 us | 224.24 us | 317.23 us | 303.59 us | 288.72 us | 1.08 ms | 809.70 us | 834.10 us | 141.60 ms |
| prism-1 | 81.63 us | **16.54 us** | 121.51 us | 98.61 us | 139.60 us | 182.57 us | 176.61 us | 168.73 us | 735.07 us | 569.40 us | 559.60 us | 88.95 ms |
| prism-2 | **209.32 us** | 499.98 us | 316.85 us | 234.54 us | 337.48 us | 493.10 us | 487.61 us | 470.88 us | 1.88 ms | 1.36 ms | 1.33 ms | 232.44 ms |
| prism-3 | 180.23 us | **84.45 us** | 287.51 us | 217.16 us | 253.51 us | 346.59 us | 388.73 us | 386.06 us | 1.56 ms | 1.11 ms | 1.09 ms | 182.43 ms |
| pubkey-1 | 69.59 us | **13.23 us** | 108.64 us | 85.37 us | 126.54 us | 160.74 us | 154.54 us | 149.97 us | 654.75 us | 460.50 us | 460.30 us | 76.27 ms |
| stablecoin_1-1 | 502.60 us | FAIL | 767.55 us | **501.93 us** | 642.51 us | 1.08 ms | 1.10 ms | 1.08 ms | 3.31 ms | 5.67 ms | 5.76 ms | FAIL |
| stablecoin_1-2 | 94.91 us | **39.43 us** | 146.57 us | 122.92 us | 159.23 us | 201.87 us | 198.40 us | 192.94 us | 872.44 us | 668.00 us | 634.40 us | 100.06 ms |
| stablecoin_1-3 | **560.40 us** | FAIL | 889.08 us | 564.42 us | 710.60 us | 1.19 ms | 1.25 ms | 1.19 ms | 3.74 ms | 6.26 ms | 6.22 ms | FAIL |
| stablecoin_1-4 | 100.39 us | **40.41 us** | 153.55 us | 131.32 us | 166.88 us | 206.14 us | 209.65 us | 205.23 us | 913.23 us | 669.70 us | 667.70 us | 100.51 ms |
| stablecoin_1-5 | **704.12 us** | FAIL | 1.09 ms | 711.97 us | 850.02 us | 1.41 ms | 1.57 ms | 1.50 ms | 4.63 ms | 7.43 ms | 7.41 ms | FAIL |
| stablecoin_1-6 | 124.02 us | **48.15 us** | 187.28 us | 160.96 us | 197.41 us | 238.42 us | 244.05 us | 237.68 us | 1.10 ms | 805.20 us | 823.10 us | 120.48 ms |
| stablecoin_2-1 | **492.70 us** | FAIL | 775.52 us | 500.72 us | 656.78 us | 1.04 ms | 1.08 ms | 1.08 ms | 3.29 ms | 5.68 ms | 5.74 ms | FAIL |
| stablecoin_2-2 | 94.89 us | **34.91 us** | 145.38 us | 120.47 us | 166.02 us | 198.32 us | 196.37 us | 193.66 us | 872.52 us | 653.10 us | 631.50 us | 96.51 ms |
| stablecoin_2-3 | **561.66 us** | FAIL | 879.32 us | 571.36 us | 717.83 us | 1.16 ms | 1.21 ms | 1.20 ms | 3.71 ms | 6.33 ms | 6.28 ms | FAIL |
| stablecoin_2-4 | 101.05 us | **38.04 us** | 154.88 us | 129.07 us | 172.00 us | 216.98 us | 208.92 us | 200.62 us | 907.20 us | 669.50 us | 679.50 us | 100.78 ms |
| token-account-1 | 94.18 us | **39.39 us** | 146.43 us | 113.61 us | 162.94 us | 219.33 us | 226.33 us | 224.96 us | 855.23 us | 610.90 us | 611.70 us | 107.00 ms |
| token-account-2 | 162.47 us | **46.88 us** | 256.75 us | 193.52 us | 234.00 us | 298.65 us | 341.55 us | 333.83 us | 1.42 ms | 951.50 us | 949.20 us | 170.72 ms |
| uniswap-1 | 194.52 us | **58.61 us** | 337.99 us | 225.43 us | 253.76 us | 352.28 us | 427.20 us | 424.21 us | 1.70 ms | 1.14 ms | 1.13 ms | 220.17 ms |
| uniswap-2 | 106.57 us | **55.02 us** | 168.74 us | 137.29 us | 183.88 us | 257.25 us | 256.77 us | 250.27 us | 1.00 ms | 728.20 us | 718.20 us | 121.26 ms |
| uniswap-3 | 877.28 us | FAIL | 1.32 ms | **868.43 us** | 932.35 us | 1.41 ms | 1.57 ms | 1.60 ms | 6.08 ms | 5.53 ms | 5.61 ms | 755.96 ms |
| uniswap-4 | 161.28 us | **62.82 us** | 242.96 us | 207.90 us | 248.09 us | 300.79 us | 301.14 us | 312.36 us | 1.45 ms | 1.06 ms | 1.05 ms | 147.70 ms |
| uniswap-5 | **570.30 us** | FAIL | 835.99 us | 591.99 us | 691.89 us | 991.26 us | 1.08 ms | 1.09 ms | 4.26 ms | 3.72 ms | 3.83 ms | 516.25 ms |
| uniswap-6 | 153.08 us | **59.74 us** | 237.05 us | 207.43 us | 236.84 us | 286.21 us | 303.36 us | 292.77 us | 1.37 ms | 967.30 us | 1.10 ms | 148.52 ms |
| vesting-1 | **177.12 us** | 229.62 us | 270.59 us | 198.87 us | 255.75 us | 352.03 us | 390.82 us | 385.62 us | 1.52 ms | 1.02 ms | 1.08 ms | 189.79 ms |

---
*Generated by [cardano-plutus-vm-benchmark](https://github.com/saib-inc/cardano-plutus-vm-benchmark)*