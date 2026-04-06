# Cardano Plutus VM Benchmark Results

**Date:** 

## Environment
```
date: 2026-03-16T20:53:32+00:00
kernel: 5.15.167.4-microsoft-standard-WSL2
cpu: AMD Ryzen 9 9900X3D 12-Core Processor
cores: 24
memory: 47Gi
```

## Summary (geometric mean across all scripts)

*Note: VMs that fail or skip a script are assigned the slowest competitor's time for that script.*

| VM | Language | Geo Mean | vs Fastest |
|---|---|---|---|
| **plutus-core (Haskell / GHC)** | Haskell / GHC | 196.60 us | 1.00x |
| **uplc-turbo Bytecode (Rust / AOT)** | Rust / AOT | 229.73 us | 1.17x |
| **uplc-turbo AST (Rust)** | Rust | 299.37 us | 1.52x |
| **Scalus Hybrid JIT (Scala / JVM)** | Scala / JVM | 401.18 us | 2.04x |
| **Plutuz (Zig)** | Zig | 407.76 us | 2.07x |
| **Chrysalis (C# / .NET AOT)** | C# / .NET AOT | 423.06 us | 2.15x |
| **Chrysalis (C# / .NET JIT)** | C# / .NET JIT | 429.73 us | 2.19x |
| **Plutigo (Go)** | Go | 446.86 us | 2.27x |
| **Scalus CEK (Scala / JVM)** | Scala / JVM | 528.46 us | 2.69x |
| **blaze-plutus (TypeScript / Node V8)** | TypeScript / Node V8 | 1.35 ms | 6.86x |
| **blaze-plutus (TypeScript / Bun JSC)** | TypeScript / Bun JSC | 1.37 ms | 6.99x |
| **opshin (Python / CPython)** | Python / CPython | 56.20 ms | 285.84x |

### Script Coverage

| VM | Passed | Failed | Missing | Total |
|---|---|---|---|---|
| plutus-core (Haskell / GHC) | 89 | 0 | 0 | 89 |
| uplc-turbo Bytecode (Rust / AOT) | 89 | 0 | 0 | 89 |
| uplc-turbo AST (Rust) | 89 | 0 | 0 | 89 |
| Scalus Hybrid JIT (Scala / JVM) | 71 | 18 | 0 | 89 |
| Plutuz (Zig) | 89 | 0 | 0 | 89 |
| Chrysalis (C# / .NET AOT) | 89 | 0 | 0 | 89 |
| Chrysalis (C# / .NET JIT) | 89 | 0 | 0 | 89 |
| Plutigo (Go) | 89 | 0 | 0 | 89 |
| Scalus CEK (Scala / JVM) | 78 | 11 | 0 | 89 |
| blaze-plutus (TypeScript / Node V8) | 89 | 0 | 0 | 89 |
| blaze-plutus (TypeScript / Bun JSC) | 89 | 0 | 0 | 89 |
| opshin (Python / CPython) | 70 | 19 | 0 | 89 |

## Per-Script Results

| Script | plutus-core (Haskell / GHC) | Scalus Hybrid JIT (Scala / JVM) | Scalus CEK (Scala / JVM) | uplc-turbo Bytecode (Rust / AOT) | uplc-turbo AST (Rust) | Plutuz (Zig) | Chrysalis (C# / .NET JIT) | Chrysalis (C# / .NET AOT) | Plutigo (Go) | blaze-plutus (TypeScript / Bun JSC) | blaze-plutus (TypeScript / Node V8) | opshin (Python / CPython) |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| auction_1-1 | 87.91 us | **34.44 us** | 135.88 us | 112.50 us | 157.57 us | 206.59 us | 203.10 us | 199.97 us | 234.72 us | 588.80 us | 592.30 us | 94.71 ms |
| auction_1-2 | **327.26 us** | 1.01 ms | 553.32 us | 358.66 us | 433.66 us | 651.92 us | 715.27 us | 729.09 us | 611.04 us | 2.00 ms | 1.86 ms | 346.78 ms |
| auction_1-3 | **321.19 us** | 730.66 us | 535.98 us | 361.96 us | 438.84 us | 634.66 us | 728.02 us | 722.32 us | 614.17 us | 1.98 ms | 1.91 ms | 342.26 ms |
| auction_1-4 | 114.71 us | **50.63 us** | 178.56 us | 144.59 us | 190.16 us | 238.12 us | 241.15 us | 232.85 us | 292.99 us | 730.00 us | 716.50 us | 115.15 ms |
| auction_2-1 | 90.04 us | **38.70 us** | 133.79 us | 111.78 us | 158.43 us | 212.00 us | 207.21 us | 195.75 us | 234.68 us | 578.70 us | 587.40 us | 91.98 ms |
| auction_2-2 | **331.22 us** | 1.01 ms | 537.21 us | 357.29 us | 446.95 us | 655.68 us | 733.98 us | 704.09 us | 613.05 us | 1.94 ms | 1.92 ms | 348.36 ms |
| auction_2-3 | **423.96 us** | 961.87 us | 714.07 us | 453.99 us | 536.17 us | 793.31 us | 921.61 us | 908.53 us | 729.84 us | 2.42 ms | 2.56 ms | 429.42 ms |
| auction_2-4 | **321.82 us** | 738.79 us | 541.96 us | 355.22 us | 442.73 us | 633.46 us | 716.00 us | 706.82 us | 613.72 us | 2.02 ms | 1.94 ms | 342.90 ms |
| auction_2-5 | 115.64 us | **51.98 us** | 175.18 us | 144.41 us | 191.01 us | 239.08 us | 246.51 us | 235.86 us | 290.30 us | 734.90 us | 740.90 us | 112.03 ms |
| coop-1 | **118.95 us** | FAIL | FAIL | 143.75 us | 171.02 us | 202.00 us | 210.16 us | 206.46 us | 376.52 us | 803.90 us | 908.60 us | 15.68 ms |
| coop-2 | **378.24 us** | FAIL | FAIL | 486.75 us | 519.46 us | 601.41 us | 605.22 us | 621.03 us | 1.04 ms | 2.69 ms | 2.78 ms | 36.10 ms |
| coop-3 | 1.15 ms | FAIL | FAIL | 1.37 ms | **1.13 ms** | 1.49 ms | 2.06 ms | 2.01 ms | 1.59 ms | 6.76 ms | 6.39 ms | 35.90 ms |
| coop-4 | **490.91 us** | FAIL | FAIL | 556.55 us | 560.42 us | 770.91 us | 791.20 us | 794.73 us | 1.03 ms | 3.34 ms | 3.22 ms | 41.39 ms |
| coop-5 | **210.37 us** | FAIL | FAIL | 254.70 us | 323.26 us | 386.19 us | 393.86 us | 403.30 us | 617.50 us | 1.45 ms | 1.55 ms | 41.61 ms |
| coop-6 | **339.10 us** | FAIL | FAIL | 447.57 us | 466.70 us | 535.14 us | 521.51 us | 550.80 us | 968.59 us | 2.32 ms | 2.43 ms | 18.95 ms |
| coop-7 | **162.79 us** | FAIL | FAIL | 209.40 us | 237.07 us | 273.46 us | 272.98 us | 273.65 us | 529.20 us | 1.12 ms | 1.22 ms | 17.70 ms |
| crowdfunding-success-1 | 104.74 us | **37.82 us** | 154.92 us | 131.43 us | 186.47 us | 237.05 us | 235.71 us | 230.36 us | 278.64 us | 715.60 us | 688.50 us | 114.42 ms |
| crowdfunding-success-2 | 105.63 us | **41.71 us** | 154.39 us | 129.19 us | 190.63 us | 236.06 us | 232.65 us | 224.84 us | 282.12 us | 701.00 us | 697.10 us | 111.25 ms |
| crowdfunding-success-3 | 107.43 us | **39.82 us** | 155.80 us | 130.49 us | 186.91 us | 241.12 us | 235.85 us | 219.72 us | 280.61 us | 690.10 us | 709.80 us | 110.09 ms |
| currency-1 | 126.99 us | **45.15 us** | 203.81 us | 147.72 us | 195.87 us | 263.53 us | 302.00 us | 291.30 us | 264.48 us | 1.02 ms | 775.40 us | 138.80 ms |
| escrow-redeem_1-1 | 179.23 us | **79.74 us** | 275.50 us | 207.07 us | 266.82 us | 365.56 us | 383.49 us | 374.75 us | 377.52 us | 1.08 ms | 1.10 ms | 188.33 ms |
| escrow-redeem_1-2 | 177.68 us | **79.31 us** | 276.78 us | 203.90 us | 269.30 us | 363.30 us | 384.93 us | 402.56 us | 377.49 us | 1.07 ms | 1.17 ms | 191.69 ms |
| escrow-redeem_2-1 | 210.20 us | **88.11 us** | 331.72 us | 237.83 us | 301.65 us | 397.04 us | 436.26 us | 434.01 us | 432.10 us | 1.22 ms | 1.31 ms | 228.77 ms |
| escrow-redeem_2-2 | 210.75 us | **78.83 us** | 328.79 us | 236.73 us | 295.36 us | 397.50 us | 435.53 us | 427.86 us | 413.70 us | 1.23 ms | 1.27 ms | 211.13 ms |
| escrow-redeem_2-3 | 209.90 us | **77.21 us** | 328.70 us | 236.18 us | 314.47 us | 402.04 us | 437.37 us | 426.12 us | 413.19 us | 1.22 ms | 1.24 ms | 217.27 ms |
| escrow-refund-1 | 77.50 us | **19.06 us** | 125.30 us | 98.78 us | 176.05 us | 234.28 us | 223.59 us | 205.10 us | 248.51 us | 629.20 us | 563.10 us | 101.68 ms |
| future-increase-margin-1 | 126.50 us | **41.48 us** | 204.77 us | 152.64 us | 196.05 us | 293.92 us | 298.53 us | 285.40 us | 261.39 us | 778.00 us | 764.30 us | 139.65 ms |
| future-increase-margin-2 | 269.09 us | **168.64 us** | 447.83 us | 313.24 us | 364.88 us | 495.94 us | 555.41 us | 536.95 us | 506.21 us | 1.61 ms | 1.60 ms | 275.24 ms |
| future-increase-margin-3 | 265.63 us | **178.02 us** | 435.89 us | 315.81 us | 364.01 us | 481.45 us | 538.50 us | 555.26 us | 510.82 us | 1.56 ms | 1.57 ms | 276.97 ms |
| future-increase-margin-4 | **256.64 us** | 912.89 us | 394.17 us | 283.78 us | 410.20 us | 598.65 us | 623.87 us | 620.43 us | 582.88 us | 1.61 ms | 1.50 ms | FAIL |
| future-increase-margin-5 | **431.53 us** | 2.12 ms | 716.04 us | 453.55 us | 571.32 us | 876.03 us | 1.01 ms | 941.13 us | 779.40 us | 4.00 ms | 3.86 ms | FAIL |
| future-pay-out-1 | 127.07 us | **41.26 us** | 200.95 us | 150.12 us | 192.56 us | 263.34 us | 290.67 us | 287.48 us | 261.30 us | 771.10 us | 746.30 us | 142.75 ms |
| future-pay-out-2 | 267.73 us | **130.19 us** | 441.22 us | 315.72 us | 373.35 us | 480.45 us | 548.53 us | 548.51 us | 511.11 us | 1.64 ms | 1.59 ms | 282.44 ms |
| future-pay-out-3 | 270.61 us | **189.13 us** | 432.53 us | 312.10 us | 365.58 us | 477.76 us | 575.22 us | 544.33 us | 512.73 us | 1.64 ms | 1.61 ms | 271.65 ms |
| future-pay-out-4 | 457.32 us | 2.20 ms | 714.35 us | **453.05 us** | 564.93 us | 880.27 us | 948.74 us | 954.07 us | 774.02 us | 3.83 ms | 3.82 ms | FAIL |
| future-settle-early-1 | 126.80 us | **41.01 us** | 203.21 us | 150.97 us | 192.73 us | 264.58 us | 293.16 us | 286.37 us | 263.22 us | 787.60 us | 747.50 us | 147.50 ms |
| future-settle-early-2 | 275.50 us | **166.86 us** | 437.36 us | 310.50 us | 365.95 us | 482.02 us | 553.48 us | 559.27 us | 519.49 us | 1.64 ms | 1.58 ms | 273.74 ms |
| future-settle-early-3 | 267.80 us | **155.71 us** | 440.74 us | 318.98 us | 367.45 us | 475.07 us | 581.75 us | 564.84 us | 516.80 us | 1.64 ms | 1.57 ms | 274.28 ms |
| future-settle-early-4 | **318.91 us** | 1.77 ms | 534.52 us | 346.49 us | 480.41 us | 764.83 us | 752.04 us | 762.19 us | 676.01 us | 3.30 ms | 3.27 ms | FAIL |
| game-sm-success_1-1 | **207.69 us** | 521.00 us | 313.62 us | 224.63 us | 335.38 us | 481.20 us | 482.77 us | 479.40 us | 488.83 us | 1.40 ms | 1.37 ms | 223.55 ms |
| game-sm-success_1-2 | 97.73 us | **36.86 us** | 155.18 us | 125.25 us | 163.57 us | 206.91 us | 214.41 us | 206.41 us | 246.45 us | 674.40 us | 642.30 us | 99.17 ms |
| game-sm-success_1-3 | **323.58 us** | 714.89 us | 530.82 us | 359.42 us | 451.37 us | 633.57 us | 703.44 us | 693.53 us | 607.53 us | 2.09 ms | 2.03 ms | 348.11 ms |
| game-sm-success_1-4 | 114.75 us | **43.70 us** | 176.95 us | 145.97 us | 185.01 us | 227.83 us | 227.30 us | 227.40 us | 278.58 us | 765.10 us | 740.80 us | 114.90 ms |
| game-sm-success_2-1 | **201.83 us** | 571.24 us | 311.09 us | 228.38 us | 333.03 us | 481.93 us | 476.54 us | 467.12 us | 497.22 us | 1.45 ms | 1.35 ms | 224.04 ms |
| game-sm-success_2-2 | 97.72 us | **36.75 us** | 156.06 us | 125.80 us | 167.52 us | 208.61 us | 201.75 us | 202.44 us | 247.49 us | 674.90 us | 633.20 us | 102.00 ms |
| game-sm-success_2-3 | **325.14 us** | 633.38 us | 535.79 us | 377.03 us | 453.03 us | 633.13 us | 710.78 us | 700.58 us | 615.92 us | 2.11 ms | 2.04 ms | 339.24 ms |
| game-sm-success_2-4 | 114.32 us | **37.24 us** | 178.81 us | 148.59 us | 187.16 us | 228.05 us | 234.05 us | 228.92 us | 279.25 us | 778.60 us | 763.40 us | 115.14 ms |
| game-sm-success_2-5 | **329.12 us** | 630.17 us | 525.37 us | 364.38 us | 450.82 us | 632.21 us | 699.48 us | 692.50 us | 616.14 us | 2.11 ms | 2.12 ms | 337.88 ms |
| game-sm-success_2-6 | 116.67 us | **37.09 us** | 177.17 us | 145.11 us | 189.23 us | 227.95 us | 239.09 us | 226.48 us | 281.63 us | 779.00 us | 839.40 us | 112.29 ms |
| guardrail-sorted-large | **220.78 us** | FAIL | FAIL | 275.22 us | 329.53 us | 346.48 us | 409.42 us | 421.85 us | 832.05 us | 1.62 ms | 1.87 ms | 20.63 ms |
| guardrail-sorted-small | **33.17 us** | FAIL | FAIL | 44.18 us | 75.36 us | 96.92 us | 99.29 us | 99.71 us | 145.96 us | 300.20 us | 387.70 us | 16.13 ms |
| guardrail-unsorted-large | **295.34 us** | FAIL | FAIL | 353.74 us | 394.37 us | 435.91 us | 570.73 us | 584.43 us | 1.00 ms | 2.11 ms | 2.15 ms | 20.69 ms |
| guardrail-unsorted-small | **33.64 us** | FAIL | FAIL | 43.06 us | 73.86 us | 94.92 us | 96.84 us | 98.91 us | 148.03 us | 291.10 us | 367.20 us | 16.28 ms |
| multisig-sm-01 | **203.01 us** | 611.90 us | 324.74 us | 228.96 us | 344.56 us | 521.32 us | 529.64 us | 507.44 us | 492.16 us | 1.45 ms | 1.49 ms | FAIL |
| multisig-sm-02 | **202.33 us** | 667.85 us | 317.85 us | 224.01 us | 340.73 us | 512.28 us | 503.31 us | 500.44 us | 488.42 us | 1.44 ms | 1.39 ms | FAIL |
| multisig-sm-03 | **203.97 us** | 636.10 us | 318.94 us | 226.72 us | 341.80 us | 526.49 us | 512.14 us | 499.63 us | 488.35 us | 1.47 ms | 1.42 ms | FAIL |
| multisig-sm-04 | **209.48 us** | 602.76 us | 323.22 us | 232.38 us | 352.87 us | 512.21 us | 525.88 us | 513.24 us | 496.62 us | 1.47 ms | 1.43 ms | FAIL |
| multisig-sm-05 | **289.90 us** | 861.75 us | 465.46 us | 313.94 us | 420.24 us | 644.48 us | 667.30 us | 689.47 us | 577.45 us | 1.95 ms | 1.86 ms | FAIL |
| multisig-sm-06 | **210.31 us** | 566.67 us | 328.32 us | 231.06 us | 352.85 us | 514.54 us | 531.09 us | 502.71 us | 500.40 us | 1.45 ms | 1.43 ms | FAIL |
| multisig-sm-07 | **202.57 us** | 582.78 us | 317.47 us | 225.41 us | 342.33 us | 502.16 us | 497.61 us | 491.70 us | 491.38 us | 1.48 ms | 1.42 ms | FAIL |
| multisig-sm-08 | **201.58 us** | 592.12 us | 319.52 us | 238.78 us | 359.89 us | 521.08 us | 502.76 us | 502.52 us | 491.61 us | 1.59 ms | 1.45 ms | FAIL |
| multisig-sm-09 | **208.40 us** | 589.60 us | 318.67 us | 245.03 us | 342.40 us | 512.00 us | 512.41 us | 507.07 us | 494.57 us | 1.61 ms | 1.44 ms | FAIL |
| multisig-sm-10 | **286.82 us** | 761.45 us | 464.70 us | 315.97 us | 417.38 us | 626.39 us | 660.91 us | 669.02 us | 636.77 us | 2.20 ms | 1.93 ms | FAIL |
| ping-pong-1 | **167.69 us** | 252.97 us | 265.85 us | 190.80 us | 293.16 us | 421.81 us | 420.21 us | 412.63 us | 423.73 us | 1.29 ms | 1.17 ms | 198.93 ms |
| ping-pong-2 | **170.37 us** | 279.26 us | 289.07 us | 189.23 us | 287.46 us | 423.37 us | 438.49 us | 412.35 us | 405.59 us | 1.27 ms | 1.19 ms | 201.90 ms |
| ping-pong_2-1 | **104.06 us** | 128.83 us | 161.20 us | 125.39 us | 227.99 us | 333.07 us | 316.95 us | 299.43 us | 323.59 us | 953.10 us | 887.70 us | 147.08 ms |
| prism-1 | 81.77 us | **12.37 us** | 129.82 us | 101.38 us | 138.95 us | 180.92 us | 181.48 us | 174.02 us | 209.63 us | 618.60 us | 542.00 us | 86.52 ms |
| prism-2 | **211.87 us** | 445.33 us | 330.88 us | 240.64 us | 359.43 us | 504.65 us | 501.37 us | 492.29 us | 490.63 us | 1.54 ms | 1.35 ms | 236.77 ms |
| prism-3 | 185.50 us | **73.45 us** | 291.95 us | 220.89 us | 262.60 us | 365.34 us | 392.48 us | 386.70 us | 375.08 us | 1.21 ms | 1.10 ms | 184.85 ms |
| pubkey-1 | 71.55 us | **11.23 us** | 108.56 us | 89.39 us | 126.94 us | 165.00 us | 164.12 us | 155.53 us | 191.24 us | 494.90 us | 459.50 us | 75.26 ms |
| stablecoin_1-1 | **509.23 us** | FAIL | 786.21 us | 510.45 us | 664.31 us | 1.08 ms | 1.10 ms | 1.11 ms | 960.31 us | 5.91 ms | 5.71 ms | FAIL |
| stablecoin_1-2 | 96.35 us | **32.43 us** | 153.47 us | 124.40 us | 163.58 us | 205.73 us | 211.47 us | 198.10 us | 250.97 us | 672.50 us | 632.30 us | 98.21 ms |
| stablecoin_1-3 | **572.05 us** | FAIL | 903.41 us | 600.99 us | 733.58 us | 1.20 ms | 1.24 ms | 1.23 ms | 1.08 ms | 6.41 ms | 6.21 ms | FAIL |
| stablecoin_1-4 | 104.43 us | **36.61 us** | 158.47 us | 130.67 us | 171.02 us | 247.50 us | 214.61 us | 212.38 us | 263.73 us | 707.40 us | 772.80 us | 103.17 ms |
| stablecoin_1-5 | **725.00 us** | FAIL | 1.13 ms | 734.32 us | 867.03 us | 1.50 ms | 1.56 ms | 1.56 ms | 1.28 ms | 7.51 ms | 7.68 ms | FAIL |
| stablecoin_1-6 | 126.36 us | **42.06 us** | 197.36 us | 163.91 us | 203.48 us | 252.85 us | 248.33 us | 247.95 us | 313.21 us | 852.40 us | 811.90 us | 120.44 ms |
| stablecoin_2-1 | 529.90 us | FAIL | 782.42 us | **515.12 us** | 666.71 us | 1.13 ms | 1.10 ms | 1.08 ms | 955.75 us | 5.82 ms | 5.81 ms | FAIL |
| stablecoin_2-2 | 97.02 us | **32.39 us** | 151.69 us | 125.53 us | 166.24 us | 211.33 us | 202.41 us | 199.50 us | 251.85 us | 654.70 us | 661.40 us | 97.86 ms |
| stablecoin_2-3 | 620.11 us | FAIL | 914.82 us | **599.29 us** | 730.75 us | 1.19 ms | 1.25 ms | 1.26 ms | 1.06 ms | 6.19 ms | 6.30 ms | FAIL |
| stablecoin_2-4 | 103.66 us | **37.46 us** | 156.28 us | 130.58 us | 175.47 us | 207.46 us | 223.23 us | 214.78 us | 263.18 us | 702.40 us | 671.90 us | 102.16 ms |
| token-account-1 | 95.76 us | **25.66 us** | 153.88 us | 116.53 us | 167.17 us | 228.14 us | 238.96 us | 233.38 us | 230.34 us | 650.30 us | 629.60 us | 110.79 ms |
| token-account-2 | 167.14 us | **44.74 us** | 266.13 us | 197.40 us | 243.01 us | 306.32 us | 355.61 us | 361.92 us | 336.80 us | 997.50 us | 998.90 us | 177.76 ms |
| uniswap-1 | 204.33 us | **53.10 us** | 348.41 us | 228.33 us | 262.90 us | 350.07 us | 447.17 us | 444.43 us | 348.55 us | 1.17 ms | 1.17 ms | 225.63 ms |
| uniswap-2 | 110.20 us | **41.53 us** | 176.43 us | 143.80 us | 193.12 us | 249.90 us | 263.13 us | 256.55 us | 269.84 us | 783.30 us | 732.70 us | 125.40 ms |
| uniswap-3 | **883.27 us** | FAIL | 1.36 ms | 892.78 us | 955.49 us | 1.52 ms | 1.70 ms | 1.65 ms | 1.24 ms | 6.15 ms | 5.58 ms | 784.98 ms |
| uniswap-4 | 162.51 us | **60.01 us** | 253.01 us | 215.00 us | 256.55 us | 302.45 us | 315.05 us | 305.66 us | 406.94 us | 1.11 ms | 1.07 ms | 150.82 ms |
| uniswap-5 | **588.27 us** | FAIL | 879.43 us | 606.80 us | 708.85 us | 1.01 ms | 1.11 ms | 1.13 ms | 940.08 us | 3.87 ms | 3.85 ms | 540.28 ms |
| uniswap-6 | 155.85 us | **54.45 us** | 247.57 us | 205.05 us | 244.11 us | 298.28 us | 319.25 us | 303.31 us | 388.70 us | 1.19 ms | 1.01 ms | 149.36 ms |
| vesting-1 | 180.72 us | **142.49 us** | 285.00 us | 202.31 us | 266.77 us | 358.57 us | 398.84 us | 397.88 us | 356.34 us | 1.10 ms | 1.08 ms | 195.57 ms |

---
*Generated by [cardano-plutus-vm-benchmark](https://github.com/saib-inc/cardano-plutus-vm-benchmark)*