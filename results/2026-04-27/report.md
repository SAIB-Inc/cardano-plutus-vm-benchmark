# Cardano Plutus VM Benchmark Results

**Date:** 2026-04-27

## Environment
```
date: 2026-04-27T05:35:38+00:00
kernel: 5.15.167.4-microsoft-standard-WSL2
cpu: AMD Ryzen 9 9900X3D 12-Core Processor
cores: 24
memory: 47Gi
```

## Summary (geometric mean across all scripts)

*Note: VMs that fail or skip a script are assigned the slowest competitor's time for that script.*

| VM | Language | Geo Mean | vs Fastest |
|---|---|---|---|
| **llvm-uplc UPLC→native JIT (C++ / LLVM)** | C++ / LLVM | 95.09 us | 1.00x |
| **Scalus UPLC→JVM JIT (Scala / JVM)** | Scala / JVM | 169.09 us | 1.78x |
| **plutus-core CEK (Haskell / GHC)** | Haskell / GHC | 176.05 us | 1.85x |
| **uplc-turbo Bytecode VM (Rust)** | Rust | 205.45 us | 2.16x |
| **Plutigo CEK (Go)** | Go | 231.87 us | 2.44x |
| **Julc CEK (Java / GraalVM)** | Java / GraalVM | 247.62 us | 2.60x |
| **uplc-turbo AST walker (Rust)** | Rust | 267.72 us | 2.82x |
| **Scalus CEK (Scala / JVM)** | Scala / JVM | 282.70 us | 2.97x |
| **Plutuz CEK (Zig)** | Zig | 365.69 us | 3.85x |
| **Chrysalis CEK (C# / .NET)** | C# / .NET | 386.98 us | 4.07x |
| **Chrysalis CEK (C# / .NET AOT)** | C# / .NET AOT | 388.27 us | 4.08x |
| **blaze-plutus CEK (TypeScript / Bun JSC)** | TypeScript / Bun JSC | 1.20 ms | 12.66x |
| **blaze-plutus CEK (TypeScript / Node V8)** | TypeScript / Node V8 | 1.21 ms | 12.72x |
| **opshin CEK (Python / CPython)** | Python / CPython | 49.69 ms | 522.52x |

### Script Coverage

| VM | Passed | Failed | Missing | Total |
|---|---|---|---|---|
| llvm-uplc UPLC→native JIT (C++ / LLVM) | 89 | 0 | 0 | 89 |
| Scalus UPLC→JVM JIT (Scala / JVM) | 89 | 0 | 0 | 89 |
| plutus-core CEK (Haskell / GHC) | 89 | 0 | 0 | 89 |
| uplc-turbo Bytecode VM (Rust) | 89 | 0 | 0 | 89 |
| Plutigo CEK (Go) | 89 | 0 | 0 | 89 |
| Julc CEK (Java / GraalVM) | 89 | 0 | 0 | 89 |
| uplc-turbo AST walker (Rust) | 89 | 0 | 0 | 89 |
| Scalus CEK (Scala / JVM) | 89 | 0 | 0 | 89 |
| Plutuz CEK (Zig) | 89 | 0 | 0 | 89 |
| Chrysalis CEK (C# / .NET) | 89 | 0 | 0 | 89 |
| Chrysalis CEK (C# / .NET AOT) | 89 | 0 | 0 | 89 |
| blaze-plutus CEK (TypeScript / Bun JSC) | 89 | 0 | 0 | 89 |
| blaze-plutus CEK (TypeScript / Node V8) | 89 | 0 | 0 | 89 |
| opshin CEK (Python / CPython) | 70 | 19 | 0 | 89 |

## Per-Script Results

| Script | plutus-core CEK (Haskell / GHC) | Scalus UPLC→JVM JIT (Scala / JVM) | Scalus CEK (Scala / JVM) | Julc CEK (Java / GraalVM) | llvm-uplc UPLC→native JIT (C++ / LLVM) | uplc-turbo Bytecode VM (Rust) | uplc-turbo AST walker (Rust) | Plutuz CEK (Zig) | Chrysalis CEK (C# / .NET) | Chrysalis CEK (C# / .NET AOT) | Plutigo CEK (Go) | blaze-plutus CEK (TypeScript / Bun JSC) | blaze-plutus CEK (TypeScript / Node V8) | opshin CEK (Python / CPython) |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| auction_1-1 | 78.93 us | **27.50 us** | 123.90 us | 110.70 us | 41.44 us | 100.03 us | 142.65 us | 188.08 us | 182.94 us | 185.01 us | 112.40 us | 537.40 us | 541.00 us | 83.67 ms |
| auction_1-2 | 299.55 us | 794.59 us | 484.89 us | 396.79 us | **148.69 us** | 323.21 us | 395.88 us | 578.22 us | 655.20 us | 655.19 us | 385.99 us | 1.72 ms | 1.83 ms | 307.29 ms |
| auction_1-3 | 286.81 us | 579.01 us | 488.44 us | 389.11 us | **155.36 us** | 324.42 us | 397.63 us | 577.53 us | 683.90 us | 658.67 us | 441.05 us | 1.75 ms | 1.81 ms | 309.09 ms |
| auction_1-4 | 102.04 us | **39.96 us** | 155.31 us | 148.44 us | 54.77 us | 130.40 us | 172.79 us | 218.22 us | 217.41 us | 217.82 us | 131.14 us | 676.20 us | 676.60 us | 101.84 ms |
| auction_2-1 | 80.10 us | **27.30 us** | 125.90 us | 101.45 us | 42.03 us | 101.47 us | 141.53 us | 188.36 us | 187.19 us | 183.99 us | 112.18 us | 533.50 us | 527.40 us | 82.71 ms |
| auction_2-2 | 298.72 us | 753.08 us | 485.45 us | 398.25 us | **149.75 us** | 321.85 us | 398.11 us | 600.15 us | 649.80 us | 670.20 us | 385.89 us | 1.74 ms | 1.76 ms | 304.75 ms |
| auction_2-3 | 387.34 us | 795.32 us | 652.20 us | 524.26 us | **197.74 us** | 409.17 us | 473.93 us | 707.00 us | 801.07 us | 826.36 us | 467.40 us | 2.23 ms | 2.24 ms | 388.16 ms |
| auction_2-4 | 295.01 us | 671.89 us | 488.68 us | 411.86 us | **148.98 us** | 323.01 us | 397.82 us | 577.72 us | 655.05 us | 656.46 us | 382.00 us | 1.75 ms | 1.74 ms | 307.95 ms |
| auction_2-5 | 102.70 us | **46.72 us** | 156.32 us | 147.29 us | 59.74 us | 131.08 us | 170.82 us | 216.22 us | 216.30 us | 213.59 us | 130.72 us | 668.80 us | 672.30 us | 100.76 ms |
| coop-1 | 104.00 us | 63.05 us | 154.85 us | 154.83 us | **59.16 us** | 128.27 us | 151.56 us | 183.50 us | 186.58 us | 187.50 us | 114.94 us | 793.70 us | 735.50 us | 13.65 ms |
| coop-2 | 340.44 us | 217.63 us | 503.50 us | 487.27 us | **182.06 us** | 437.41 us | 476.48 us | 540.27 us | 550.20 us | 565.05 us | 358.29 us | 2.43 ms | 2.43 ms | 31.04 ms |
| coop-3 | 1.03 ms | 726.52 us | 1.76 ms | 1.49 ms | **593.21 us** | 1.21 ms | 1.01 ms | 1.41 ms | 1.81 ms | 1.84 ms | 1.04 ms | 5.59 ms | 5.88 ms | 30.47 ms |
| coop-4 | 455.25 us | 282.22 us | 664.15 us | 804.62 us | **235.66 us** | 499.19 us | 501.94 us | 717.59 us | 717.10 us | 733.90 us | 436.70 us | 2.85 ms | 2.88 ms | 35.78 ms |
| coop-5 | 186.85 us | 121.96 us | 269.82 us | 265.74 us | **99.53 us** | 225.51 us | 278.63 us | 345.48 us | 353.51 us | 355.83 us | 222.37 us | 1.40 ms | 1.31 ms | 34.20 ms |
| coop-6 | 309.49 us | 185.24 us | 467.34 us | 464.08 us | **169.85 us** | 403.26 us | 417.11 us | 459.47 us | 475.67 us | 487.10 us | 313.23 us | 2.16 ms | 2.10 ms | 16.44 ms |
| coop-7 | 145.65 us | 87.64 us | 216.99 us | 222.79 us | **82.14 us** | 184.53 us | 212.30 us | 247.02 us | 255.01 us | 252.90 us | 156.81 us | 1.09 ms | 1.02 ms | 15.57 ms |
| crowdfunding-success-1 | 96.98 us | **32.81 us** | 144.66 us | 126.90 us | 50.60 us | 115.45 us | 165.97 us | 216.87 us | 212.59 us | 208.37 us | 132.36 us | 633.00 us | 634.10 us | 101.04 ms |
| crowdfunding-success-2 | 96.70 us | **36.52 us** | 140.90 us | 122.50 us | 50.16 us | 116.04 us | 166.06 us | 215.02 us | 219.15 us | 208.81 us | 132.86 us | 619.70 us | 635.70 us | 99.32 ms |
| crowdfunding-success-3 | 95.05 us | **34.40 us** | 143.18 us | 127.01 us | 50.71 us | 116.99 us | 167.17 us | 214.35 us | 213.91 us | 209.56 us | 132.89 us | 626.10 us | 634.00 us | 98.29 ms |
| currency-1 | 114.59 us | **31.11 us** | 185.71 us | 156.74 us | 59.48 us | 132.36 us | 173.81 us | 239.94 us | 265.38 us | 266.77 us | 158.05 us | 678.50 us | 689.30 us | 125.41 ms |
| escrow-redeem_1-1 | 161.90 us | **59.64 us** | 254.19 us | 215.52 us | 85.67 us | 184.70 us | 239.86 us | 331.53 us | 366.03 us | 356.05 us | 212.44 us | 983.10 us | 994.30 us | 166.33 ms |
| escrow-redeem_1-2 | 161.16 us | **62.46 us** | 252.62 us | 204.73 us | 83.47 us | 182.69 us | 242.32 us | 323.68 us | 355.00 us | 347.80 us | 212.64 us | 965.50 us | 992.10 us | 169.42 ms |
| escrow-redeem_2-1 | 187.58 us | **71.97 us** | 297.95 us | 242.34 us | 98.25 us | 211.82 us | 265.66 us | 356.99 us | 405.52 us | 398.87 us | 236.25 us | 1.10 ms | 1.14 ms | 189.37 ms |
| escrow-redeem_2-2 | 185.66 us | **76.13 us** | 294.98 us | 249.94 us | 97.27 us | 212.95 us | 266.16 us | 358.24 us | 398.93 us | 396.10 us | 236.34 us | 1.10 ms | 1.13 ms | 189.78 ms |
| escrow-redeem_2-3 | 185.19 us | **68.27 us** | 294.46 us | 239.54 us | 102.45 us | 214.66 us | 267.57 us | 358.44 us | 394.03 us | 395.78 us | 236.04 us | 1.10 ms | 1.13 ms | 191.54 ms |
| escrow-refund-1 | 70.78 us | **18.68 us** | 110.65 us | 92.48 us | 39.42 us | 85.89 us | 154.98 us | 210.54 us | 198.22 us | 196.06 us | 129.62 us | 517.40 us | 525.40 us | 92.65 ms |
| future-increase-margin-1 | 113.40 us | **35.02 us** | 183.77 us | 154.89 us | 57.30 us | 131.79 us | 174.74 us | 238.30 us | 260.90 us | 267.24 us | 157.95 us | 677.10 us | 707.30 us | 124.91 ms |
| future-increase-margin-2 | 242.16 us | **116.56 us** | 407.63 us | 319.85 us | 127.44 us | 277.35 us | 327.52 us | 436.01 us | 495.15 us | 500.69 us | 293.09 us | 1.42 ms | 1.47 ms | 246.71 ms |
| future-increase-margin-3 | 243.68 us | **125.95 us** | 396.71 us | 325.57 us | 126.98 us | 277.55 us | 325.77 us | 432.33 us | 494.24 us | 507.21 us | 293.54 us | 1.43 ms | 1.46 ms | 248.46 ms |
| future-increase-margin-4 | 229.47 us | 1.06 ms | 370.29 us | 323.18 us | **119.22 us** | 250.45 us | 365.60 us | 543.08 us | 563.73 us | 575.67 us | 349.73 us | 1.44 ms | 1.43 ms | FAIL |
| future-increase-margin-5 | 392.91 us | 1.61 ms | 652.58 us | 552.20 us | **223.53 us** | 407.11 us | 521.75 us | 785.83 us | 882.29 us | 859.18 us | 471.49 us | 3.55 ms | 3.50 ms | FAIL |
| future-pay-out-1 | 113.24 us | **29.36 us** | 186.57 us | 148.53 us | 56.87 us | 131.46 us | 173.27 us | 241.71 us | 261.73 us | 267.33 us | 157.22 us | 703.50 us | 702.00 us | 125.31 ms |
| future-pay-out-2 | 245.30 us | 131.39 us | 396.68 us | 321.33 us | **125.99 us** | 277.59 us | 326.98 us | 433.08 us | 496.96 us | 505.58 us | 292.87 us | 1.46 ms | 1.46 ms | 245.58 ms |
| future-pay-out-3 | 240.51 us | 135.70 us | 407.50 us | 317.28 us | **126.94 us** | 280.55 us | 326.12 us | 432.67 us | 493.00 us | 500.40 us | 293.56 us | 1.47 ms | 1.46 ms | 247.37 ms |
| future-pay-out-4 | 392.21 us | 1.50 ms | 663.04 us | 553.12 us | **215.67 us** | 408.42 us | 506.98 us | 786.33 us | 867.98 us | 860.39 us | 470.11 us | 3.50 ms | 3.70 ms | FAIL |
| future-settle-early-1 | 116.31 us | **33.35 us** | 185.65 us | 153.27 us | 58.78 us | 131.42 us | 181.24 us | 241.65 us | 263.38 us | 266.22 us | 157.90 us | 694.70 us | 700.90 us | 126.48 ms |
| future-settle-early-2 | 243.33 us | 146.18 us | 397.08 us | 317.38 us | **130.72 us** | 277.87 us | 328.06 us | 435.69 us | 490.15 us | 512.63 us | 291.69 us | 1.44 ms | 1.45 ms | 244.62 ms |
| future-settle-early-3 | 243.62 us | 136.28 us | 402.79 us | 318.50 us | **127.57 us** | 285.38 us | 326.11 us | 434.92 us | 499.94 us | 501.33 us | 290.77 us | 1.43 ms | 1.48 ms | 246.06 ms |
| future-settle-early-4 | 292.79 us | 1.46 ms | 513.81 us | 424.58 us | **169.69 us** | 319.78 us | 423.05 us | 648.14 us | 700.87 us | 678.49 us | 377.76 us | 2.94 ms | 2.95 ms | FAIL |
| game-sm-success_1-1 | 184.57 us | 464.92 us | 287.35 us | 236.97 us | **92.86 us** | 209.62 us | 298.29 us | 428.15 us | 443.65 us | 439.01 us | 272.23 us | 1.23 ms | 1.26 ms | 199.88 ms |
| game-sm-success_1-2 | 87.81 us | **33.63 us** | 140.25 us | 126.91 us | 48.30 us | 113.04 us | 148.67 us | 190.25 us | 188.25 us | 185.93 us | 113.64 us | 574.00 us | 583.00 us | 88.47 ms |
| game-sm-success_1-3 | 290.88 us | 595.55 us | 479.28 us | 390.68 us | **151.96 us** | 326.43 us | 406.19 us | 575.07 us | 642.93 us | 641.87 us | 380.85 us | 1.86 ms | 1.89 ms | 301.20 ms |
| game-sm-success_1-4 | 103.07 us | **35.66 us** | 158.45 us | 145.15 us | 58.44 us | 131.42 us | 168.87 us | 207.55 us | 208.23 us | 209.40 us | 125.00 us | 691.30 us | 691.40 us | 102.83 ms |
| game-sm-success_2-1 | 181.20 us | 453.43 us | 276.71 us | 241.44 us | **93.68 us** | 205.37 us | 298.87 us | 434.15 us | 436.80 us | 433.90 us | 270.66 us | 1.24 ms | 1.25 ms | 198.47 ms |
| game-sm-success_2-2 | 88.46 us | **31.84 us** | 137.31 us | 124.83 us | 48.22 us | 112.08 us | 147.35 us | 186.87 us | 187.32 us | 186.35 us | 112.91 us | 578.90 us | 587.80 us | 89.50 ms |
| game-sm-success_2-3 | 294.21 us | 882.34 us | 484.54 us | 390.21 us | **150.19 us** | 325.33 us | 400.19 us | 571.75 us | 640.16 us | 657.54 us | 380.24 us | 1.85 ms | 1.86 ms | 302.59 ms |
| game-sm-success_2-4 | 101.63 us | **37.69 us** | 160.20 us | 144.69 us | 57.22 us | 130.39 us | 165.05 us | 210.05 us | 206.28 us | 206.57 us | 124.73 us | 685.70 us | 686.20 us | 103.23 ms |
| game-sm-success_2-5 | 291.77 us | 619.91 us | 479.45 us | 397.08 us | **153.80 us** | 323.98 us | 402.64 us | 573.32 us | 632.12 us | 644.65 us | 381.42 us | 1.84 ms | 1.87 ms | 302.72 ms |
| game-sm-success_2-6 | 103.17 us | **36.33 us** | 160.63 us | 146.44 us | 56.68 us | 130.72 us | 167.41 us | 206.07 us | 218.05 us | 206.45 us | 124.73 us | 682.70 us | 687.70 us | 101.42 ms |
| guardrail-sorted-large | **196.31 us** | 298.30 us | 389.10 us | 394.69 us | 202.58 us | 242.46 us | 301.76 us | 295.39 us | 364.57 us | 396.17 us | 261.61 us | 1.48 ms | 1.44 ms | 18.36 ms |
| guardrail-sorted-small | 30.25 us | 99.19 us | 51.32 us | 45.64 us | **14.80 us** | 40.32 us | 66.46 us | 87.30 us | 95.04 us | 91.94 us | 53.04 us | 315.10 us | 262.40 us | 14.30 ms |
| guardrail-unsorted-large | **267.87 us** | 344.17 us | 559.53 us | 372.43 us | 269.81 us | 320.77 us | 360.08 us | 392.46 us | 498.87 us | 520.88 us | 331.93 us | 1.90 ms | 1.88 ms | 18.62 ms |
| guardrail-unsorted-small | 30.16 us | 93.53 us | 47.55 us | 44.58 us | **14.26 us** | 39.70 us | 66.38 us | 85.68 us | 86.53 us | 88.30 us | 51.37 us | 337.50 us | 261.20 us | 14.13 ms |
| multisig-sm-01 | 187.04 us | 620.54 us | 297.52 us | 256.37 us | **92.67 us** | 211.49 us | 310.80 us | 460.27 us | 468.10 us | 472.32 us | 290.32 us | 1.28 ms | 1.31 ms | FAIL |
| multisig-sm-02 | 183.60 us | 603.35 us | 286.26 us | 245.90 us | **99.72 us** | 206.11 us | 306.10 us | 456.25 us | 457.25 us | 457.36 us | 283.79 us | 1.26 ms | 1.28 ms | FAIL |
| multisig-sm-03 | 181.44 us | 831.35 us | 287.12 us | 253.36 us | **97.41 us** | 206.24 us | 308.07 us | 457.32 us | 459.12 us | 458.94 us | 286.90 us | 1.27 ms | 1.30 ms | FAIL |
| multisig-sm-04 | 182.74 us | 648.73 us | 292.05 us | 254.75 us | **97.60 us** | 206.59 us | 308.73 us | 458.54 us | 462.88 us | 469.42 us | 291.08 us | 1.31 ms | 1.31 ms | FAIL |
| multisig-sm-05 | 257.26 us | 831.61 us | 426.87 us | 399.26 us | **135.57 us** | 281.56 us | 374.27 us | 578.85 us | 605.63 us | 603.82 us | 356.02 us | 1.65 ms | 1.70 ms | FAIL |
| multisig-sm-06 | 185.88 us | 569.13 us | 297.84 us | 266.75 us | **96.61 us** | 208.51 us | 311.07 us | 464.42 us | 463.22 us | 469.18 us | 290.40 us | 1.28 ms | 1.31 ms | FAIL |
| multisig-sm-07 | 182.43 us | 584.31 us | 289.98 us | 254.75 us | **92.52 us** | 204.16 us | 307.70 us | 455.99 us | 455.73 us | 457.31 us | 285.19 us | 1.24 ms | 1.27 ms | FAIL |
| multisig-sm-08 | 181.71 us | 553.01 us | 290.09 us | 261.79 us | **97.10 us** | 203.65 us | 310.09 us | 450.19 us | 483.70 us | 454.85 us | 287.06 us | 1.26 ms | 1.28 ms | FAIL |
| multisig-sm-09 | 184.58 us | 642.68 us | 296.51 us | 260.26 us | **97.47 us** | 206.93 us | 311.48 us | 459.46 us | 464.56 us | 462.18 us | 289.69 us | 1.29 ms | 1.30 ms | FAIL |
| multisig-sm-10 | 262.16 us | 774.43 us | 428.76 us | 370.91 us | **132.39 us** | 280.44 us | 373.07 us | 562.40 us | 596.85 us | 603.34 us | 356.46 us | 1.67 ms | 1.70 ms | FAIL |
| ping-pong-1 | 151.41 us | 311.09 us | 243.54 us | 203.91 us | **76.89 us** | 171.13 us | 261.19 us | 381.18 us | 388.12 us | 379.55 us | 240.52 us | 1.03 ms | 1.06 ms | 177.38 ms |
| ping-pong-2 | 152.22 us | 248.41 us | 243.41 us | 206.40 us | **76.89 us** | 170.14 us | 260.12 us | 380.79 us | 385.54 us | 382.79 us | 238.01 us | 1.04 ms | 1.06 ms | 177.28 ms |
| ping-pong_2-1 | 93.50 us | 181.96 us | 150.67 us | 125.88 us | **47.27 us** | 109.11 us | 205.16 us | 297.83 us | 279.54 us | 274.36 us | 185.84 us | 726.90 us | 739.50 us | 130.39 ms |
| prism-1 | 73.16 us | **12.94 us** | 115.83 us | 106.13 us | 40.03 us | 90.75 us | 125.31 us | 163.18 us | 166.89 us | 164.41 us | 98.05 us | 497.30 us | 502.10 us | 76.71 ms |
| prism-2 | 188.82 us | 402.08 us | 304.65 us | 247.90 us | **99.09 us** | 217.84 us | 310.40 us | 447.32 us | 451.20 us | 447.06 us | 278.24 us | 1.22 ms | 1.25 ms | 210.73 ms |
| prism-3 | 166.88 us | **69.36 us** | 272.32 us | 235.24 us | 88.72 us | 196.84 us | 240.24 us | 324.96 us | 348.54 us | 357.68 us | 204.02 us | 1.00 ms | 1.02 ms | 166.08 ms |
| pubkey-1 | 63.12 us | **10.72 us** | 102.25 us | 90.02 us | 37.67 us | 78.89 us | 116.33 us | 151.68 us | 143.73 us | 148.10 us | 90.25 us | 432.60 us | 430.50 us | 67.95 ms |
| stablecoin_1-1 | 448.22 us | 4.25 ms | 715.18 us | 720.37 us | **254.49 us** | 457.45 us | 596.48 us | 955.20 us | 1.01 ms | 1.00 ms | 517.30 us | 5.25 ms | 5.25 ms | FAIL |
| stablecoin_1-2 | 87.07 us | **36.31 us** | 134.88 us | 123.81 us | 50.08 us | 112.05 us | 149.33 us | 183.66 us | 184.67 us | 186.57 us | 111.30 us | 582.40 us | 586.70 us | 90.64 ms |
| stablecoin_1-3 | 508.50 us | 4.06 ms | 944.80 us | 875.34 us | **276.54 us** | 523.27 us | 649.61 us | 1.08 ms | 1.13 ms | 1.15 ms | 580.77 us | 5.70 ms | 5.70 ms | FAIL |
| stablecoin_1-4 | 92.45 us | **33.78 us** | 144.91 us | 134.52 us | 51.26 us | 118.23 us | 155.46 us | 192.00 us | 192.53 us | 191.78 us | 116.73 us | 627.10 us | 622.40 us | 93.41 ms |
| stablecoin_1-5 | 648.21 us | 4.00 ms | 1.02 ms | 1.15 ms | **328.36 us** | 657.51 us | 772.09 us | 1.34 ms | 1.37 ms | 1.38 ms | 707.11 us | 6.66 ms | 6.80 ms | FAIL |
| stablecoin_1-6 | 112.21 us | **41.83 us** | 178.05 us | 164.67 us | 65.48 us | 145.87 us | 182.32 us | 223.43 us | 224.69 us | 229.95 us | 134.71 us | 740.10 us | 750.00 us | 108.65 ms |
| stablecoin_2-1 | 445.89 us | 4.22 ms | 719.96 us | 724.48 us | **254.80 us** | 460.35 us | 594.57 us | 963.69 us | 1.05 ms | 1.00 ms | 517.59 us | 5.09 ms | 5.14 ms | FAIL |
| stablecoin_2-2 | 86.26 us | **33.91 us** | 135.46 us | 127.58 us | 48.49 us | 113.00 us | 150.09 us | 188.03 us | 186.56 us | 183.54 us | 110.87 us | 570.90 us | 588.60 us | 88.78 ms |
| stablecoin_2-3 | 509.58 us | 4.30 ms | 831.27 us | 858.39 us | **287.86 us** | 523.74 us | 651.24 us | 1.08 ms | 1.14 ms | 1.15 ms | 579.91 us | 5.53 ms | 5.60 ms | FAIL |
| stablecoin_2-4 | 91.69 us | **34.18 us** | 146.34 us | 134.58 us | 51.22 us | 119.36 us | 155.54 us | 190.90 us | 189.91 us | 193.91 us | 115.06 us | 608.10 us | 623.90 us | 91.99 ms |
| token-account-1 | 84.84 us | **21.79 us** | 137.40 us | 121.70 us | 48.03 us | 103.08 us | 149.11 us | 207.27 us | 210.78 us | 216.62 us | 129.65 us | 562.00 us | 566.60 us | 97.88 ms |
| token-account-2 | 149.91 us | **45.00 us** | 244.78 us | 200.36 us | 81.81 us | 179.59 us | 213.07 us | 280.98 us | 314.79 us | 321.88 us | 187.96 us | 863.70 us | 883.10 us | 157.16 ms |
| uniswap-1 | 179.21 us | **49.78 us** | 311.88 us | 244.75 us | 94.46 us | 205.31 us | 234.33 us | 326.31 us | 395.42 us | 402.24 us | 233.95 us | 1.05 ms | 1.07 ms | 197.60 ms |
| uniswap-2 | 99.16 us | **36.46 us** | 159.87 us | 147.01 us | 52.82 us | 123.18 us | 169.62 us | 228.68 us | 238.71 us | 239.02 us | 143.53 us | 658.00 us | 665.70 us | 111.53 ms |
| uniswap-3 | 804.13 us | 693.78 us | 1.23 ms | 1.06 ms | **355.01 us** | 809.79 us | 850.45 us | 1.31 ms | 1.46 ms | 1.53 ms | 855.65 us | 4.96 ms | 5.09 ms | 691.24 ms |
| uniswap-4 | 145.47 us | **57.92 us** | 228.43 us | 195.46 us | 83.66 us | 195.19 us | 231.15 us | 276.05 us | 282.67 us | 285.83 us | 182.64 us | 1.02 ms | 976.00 us | 136.09 ms |
| uniswap-5 | 528.17 us | 689.11 us | 795.74 us | 677.29 us | **255.88 us** | 561.46 us | 640.71 us | 923.95 us | 989.96 us | 1.03 ms | 604.65 us | 3.40 ms | 3.44 ms | 469.36 ms |
| uniswap-6 | 138.70 us | **53.28 us** | 224.11 us | 205.71 us | 83.72 us | 182.86 us | 220.95 us | 269.67 us | 274.65 us | 276.68 us | 163.38 us | 902.40 us | 926.90 us | 133.52 ms |
| vesting-1 | 160.96 us | 111.83 us | 260.29 us | 213.06 us | **80.71 us** | 181.58 us | 240.23 us | 321.80 us | 361.06 us | 361.69 us | 216.93 us | 963.90 us | 978.60 us | 174.59 ms |

---
*Generated by [cardano-plutus-vm-benchmark](https://github.com/saib-inc/cardano-plutus-vm-benchmark)*