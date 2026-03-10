# Cardano Plutus VM Benchmark Results

**Date:** 

## Environment
```
date: 2026-03-10T14:53:00+00:00
kernel: 5.15.167.4-microsoft-standard-WSL2
cpu: AMD Ryzen 9 9900X3D 12-Core Processor
cores: 24
memory: 47Gi
```

## Summary (geometric mean across all scripts)

| VM | Language | Geo Mean | vs Fastest |
|---|---|---|---|
| **plutus-core (Haskell / GHC)** | Haskell / GHC | 190.03 us | 1.00x |
| **Plutuz (Zig)** | Zig | 390.04 us | 2.05x |
| **uplc-turbo (Rust)** | Rust | 495.36 us | 2.61x |
| **Chrysalis (C# / .NET JIT)** | C# / .NET JIT | 544.35 us | 2.86x |
| **Chrysalis (C# / .NET AOT)** | C# / .NET AOT | 561.05 us | 2.95x |
| **blaze-plutus (TypeScript / Node V8)** | TypeScript / Node V8 | 1.21 ms | 6.37x |
| **blaze-plutus (TypeScript / Bun JSC)** | TypeScript / Bun JSC | 1.25 ms | 6.57x |
| **Plutigo (Go)** | Go | 2.28 ms | 11.98x |
| **opshin (Python / CPython)** | Python / CPython | 121.99 ms | 641.96x |

## Per-Script Results

| Script | plutus-core (Haskell / GHC) | uplc-turbo (Rust) | Plutuz (Zig) | Chrysalis (C# / .NET JIT) | Chrysalis (C# / .NET AOT) | Plutigo (Go) | blaze-plutus (TypeScript / Bun JSC) | blaze-plutus (TypeScript / Node V8) | opshin (Python / CPython) |
|---|---|---|---|---|---|---|---|---|---|
| auction_1-1 | **85.58 us** | 259.40 us | 200.95 us | 281.39 us | 279.49 us | 1.09 ms | 556.60 us | 547.50 us | 90.22 ms |
| auction_1-2 | **321.53 us** | 789.73 us | 628.59 us | 894.45 us | 925.24 us | 3.59 ms | 1.78 ms | 1.75 ms | 324.21 ms |
| auction_1-3 | **313.97 us** | 752.83 us | 615.90 us | 893.44 us | 915.43 us | 3.65 ms | 1.77 ms | 1.76 ms | 324.48 ms |
| auction_1-4 | **110.33 us** | 321.99 us | 231.38 us | 315.07 us | 318.53 us | 1.37 ms | 699.80 us | 677.40 us | 105.79 ms |
| auction_2-1 | **85.58 us** | 263.47 us | 196.93 us | 262.08 us | 268.29 us | 1.09 ms | 544.60 us | 532.50 us | 90.27 ms |
| auction_2-2 | **317.53 us** | 758.33 us | 619.27 us | 886.02 us | 914.75 us | 3.62 ms | 1.74 ms | 1.75 ms | 323.44 ms |
| auction_2-3 | **412.29 us** | 945.35 us | 735.05 us | 1.15 ms | 1.12 ms | 4.65 ms | 2.22 ms | 2.20 ms | 411.94 ms |
| auction_2-4 | **309.66 us** | 763.26 us | 614.87 us | 893.15 us | 934.14 us | 3.66 ms | 1.77 ms | 1.74 ms | 326.00 ms |
| auction_2-5 | **109.05 us** | 312.30 us | 234.65 us | 315.53 us | 322.19 us | 1.39 ms | 763.00 us | 666.80 us | 108.72 ms |
| coop-1 | **111.83 us** | - | 195.73 us | 281.41 us | 275.35 us | 1.46 ms | 829.10 us | 724.50 us | 14.76 ms |
| coop-2 | **367.40 us** | - | 567.97 us | 828.16 us | 831.06 us | 4.39 ms | 2.61 ms | 2.38 ms | 34.62 ms |
| coop-3 | **1.08 ms** | - | 1.40 ms | 2.50 ms | 2.68 ms | 12.04 ms | 6.07 ms | 5.87 ms | 34.48 ms |
| coop-4 | **483.22 us** | - | 691.54 us | 1.03 ms | 1.04 ms | 5.13 ms | 2.89 ms | 2.84 ms | 38.65 ms |
| coop-5 | **198.99 us** | - | 370.05 us | 539.46 us | 539.56 us | 2.51 ms | 1.33 ms | 1.28 ms | 36.93 ms |
| coop-6 | **329.54 us** | - | 493.00 us | 737.29 us | 722.88 us | 4.03 ms | 2.11 ms | 2.06 ms | 18.06 ms |
| coop-7 | **155.18 us** | - | 265.48 us | 379.65 us | 375.51 us | 2.04 ms | 1.05 ms | 1.03 ms | 16.98 ms |
| crowdfunding-success-1 | **103.33 us** | 292.86 us | 228.90 us | 300.76 us | 314.90 us | 1.29 ms | 649.80 us | 643.70 us | 106.07 ms |
| crowdfunding-success-2 | **102.18 us** | 295.83 us | 230.23 us | 309.68 us | 320.65 us | 1.29 ms | 648.10 us | 649.20 us | 105.08 ms |
| crowdfunding-success-3 | **102.62 us** | 289.72 us | 229.88 us | 306.30 us | 316.18 us | 1.29 ms | 651.50 us | 647.40 us | 106.06 ms |
| currency-1 | **122.06 us** | 324.14 us | 259.40 us | 359.55 us | 377.94 us | 1.50 ms | 720.30 us | 703.80 us | 132.62 ms |
| escrow-redeem_1-1 | **174.20 us** | 436.67 us | 346.83 us | 484.68 us | 517.56 us | 2.06 ms | 1.01 ms | 1.07 ms | 175.12 ms |
| escrow-redeem_1-2 | **172.81 us** | 435.93 us | 347.83 us | 496.83 us | 505.71 us | 2.05 ms | 1.02 ms | 1.01 ms | 178.82 ms |
| escrow-redeem_2-1 | **202.53 us** | 491.99 us | 381.49 us | 561.93 us | 558.79 us | 2.36 ms | 1.15 ms | 1.15 ms | 208.89 ms |
| escrow-redeem_2-2 | **199.12 us** | 491.65 us | 381.13 us | 553.13 us | 562.59 us | 2.36 ms | 1.16 ms | 1.18 ms | 207.87 ms |
| escrow-redeem_2-3 | **199.89 us** | 492.62 us | 387.24 us | 545.63 us | 557.65 us | 2.40 ms | 1.16 ms | 1.20 ms | 204.37 ms |
| escrow-refund-1 | **75.74 us** | 260.20 us | 229.79 us | 287.52 us | 307.44 us | 1.06 ms | 541.20 us | 564.40 us | 95.86 ms |
| future-increase-margin-1 | **121.73 us** | 321.47 us | 265.13 us | 360.94 us | 377.11 us | 1.49 ms | 716.10 us | 690.20 us | 132.36 ms |
| future-increase-margin-2 | **263.41 us** | 620.99 us | 469.40 us | 698.49 us | 712.37 us | 3.06 ms | 1.48 ms | 1.44 ms | 262.88 ms |
| future-increase-margin-3 | **260.01 us** | 620.92 us | 471.05 us | 689.17 us | 703.29 us | 3.07 ms | 1.48 ms | 1.43 ms | 262.11 ms |
| future-increase-margin-4 | **244.79 us** | 666.98 us | 586.42 us | 777.17 us | 834.06 us | 2.98 ms | 1.47 ms | 1.41 ms | - |
| future-increase-margin-5 | **416.04 us** | 958.03 us | 859.43 us | 1.16 ms | 1.20 ms | 4.39 ms | 3.62 ms | 3.51 ms | - |
| future-pay-out-1 | **121.46 us** | 319.91 us | 255.31 us | 362.68 us | 380.52 us | 1.49 ms | 744.90 us | 718.50 us | 133.48 ms |
| future-pay-out-2 | **264.13 us** | 615.01 us | 469.07 us | 693.97 us | 704.54 us | 3.06 ms | 1.53 ms | 1.44 ms | 263.55 ms |
| future-pay-out-3 | **258.78 us** | 618.37 us | 468.99 us | 684.00 us | 712.93 us | 3.09 ms | 1.55 ms | 1.44 ms | 261.53 ms |
| future-pay-out-4 | **420.70 us** | 951.61 us | 861.99 us | 1.17 ms | 1.19 ms | 4.38 ms | 3.59 ms | 3.52 ms | - |
| future-settle-early-1 | **122.22 us** | 321.55 us | 254.13 us | 363.86 us | 389.04 us | 1.51 ms | 744.80 us | 693.10 us | 132.87 ms |
| future-settle-early-2 | **258.95 us** | 618.58 us | 461.47 us | 695.64 us | 699.65 us | 3.07 ms | 1.52 ms | 1.44 ms | 260.98 ms |
| future-settle-early-3 | **261.10 us** | 632.26 us | 471.15 us | 685.40 us | 702.78 us | 3.07 ms | 1.53 ms | 1.44 ms | 260.41 ms |
| future-settle-early-4 | **315.86 us** | 777.02 us | 694.36 us | 933.68 us | 950.41 us | 3.35 ms | 3.14 ms | 2.95 ms | - |
| game-sm-success_1-1 | **195.48 us** | 526.20 us | 462.09 us | 602.99 us | 637.57 us | 2.36 ms | 1.28 ms | 1.22 ms | 214.44 ms |
| game-sm-success_1-2 | **95.07 us** | 275.64 us | 199.27 us | 268.53 us | 275.59 us | 1.20 ms | 621.40 us | 587.80 us | 94.30 ms |
| game-sm-success_1-3 | **309.61 us** | 754.31 us | 630.19 us | 890.19 us | 905.90 us | 3.66 ms | 1.92 ms | 1.84 ms | 325.17 ms |
| game-sm-success_1-4 | **109.57 us** | 305.77 us | 225.64 us | 300.90 us | 315.52 us | 1.38 ms | 721.30 us | 685.10 us | 104.89 ms |
| game-sm-success_2-1 | **195.69 us** | 531.53 us | 463.44 us | 605.34 us | 630.91 us | 2.38 ms | 1.28 ms | 1.24 ms | 211.59 ms |
| game-sm-success_2-2 | **96.08 us** | 267.43 us | 198.84 us | 290.13 us | 273.10 us | 1.21 ms | 617.70 us | 601.00 us | 94.97 ms |
| game-sm-success_2-3 | **311.27 us** | 759.43 us | 613.57 us | 881.33 us | 927.18 us | 3.67 ms | 1.93 ms | 1.86 ms | 322.87 ms |
| game-sm-success_2-4 | **113.27 us** | 306.96 us | 221.00 us | 303.11 us | 310.42 us | 1.39 ms | 720.50 us | 710.30 us | 106.43 ms |
| game-sm-success_2-5 | **313.77 us** | 752.20 us | 611.13 us | 886.00 us | 902.35 us | 3.66 ms | 1.92 ms | 1.86 ms | 326.09 ms |
| game-sm-success_2-6 | **110.72 us** | 304.39 us | 221.06 us | 300.97 us | 313.62 us | 1.38 ms | 719.20 us | 710.60 us | 105.79 ms |
| guardrail-sorted-large | **215.04 us** | - | 322.78 us | 519.23 us | 540.63 us | 2.80 ms | 1.49 ms | 1.46 ms | 19.82 ms |
| guardrail-sorted-small | **32.73 us** | - | 93.19 us | 128.83 us | 147.62 us | 469.62 us | 275.20 us | 263.70 us | 15.31 ms |
| guardrail-unsorted-large | **294.34 us** | - | 414.24 us | 695.41 us | 710.78 us | 3.63 ms | 1.98 ms | 1.79 ms | 19.80 ms |
| guardrail-unsorted-small | **32.56 us** | - | 91.07 us | 130.45 us | 148.66 us | 460.81 us | 268.70 us | 265.90 us | 15.49 ms |
| multisig-sm-01 | **203.45 us** | - | 487.82 us | 655.41 us | 686.88 us | 2.47 ms | 1.34 ms | 1.30 ms | - |
| multisig-sm-02 | **200.80 us** | - | 490.20 us | 638.50 us | 663.04 us | 2.41 ms | 1.31 ms | 1.27 ms | - |
| multisig-sm-03 | **196.29 us** | - | 485.34 us | 642.96 us | 669.88 us | 2.41 ms | 1.34 ms | 1.27 ms | - |
| multisig-sm-04 | **201.24 us** | - | 486.46 us | 655.26 us | 680.72 us | 2.42 ms | 1.37 ms | 1.28 ms | - |
| multisig-sm-05 | **286.62 us** | - | 594.54 us | 843.42 us | 860.71 us | 3.28 ms | 1.75 ms | 1.66 ms | - |
| multisig-sm-06 | **200.41 us** | - | 490.62 us | 652.65 us | 690.27 us | 2.44 ms | 1.34 ms | 1.29 ms | - |
| multisig-sm-07 | **194.75 us** | - | 484.40 us | 635.13 us | 666.57 us | 2.40 ms | 1.37 ms | 1.25 ms | - |
| multisig-sm-08 | **198.89 us** | - | 484.56 us | 638.77 us | 677.87 us | 2.42 ms | 1.33 ms | 1.28 ms | - |
| multisig-sm-09 | **200.75 us** | - | 496.48 us | 647.63 us | 681.63 us | 2.44 ms | 1.32 ms | 1.28 ms | - |
| multisig-sm-1 | - | 558.89 us | - | - | - | - | - | - | - |
| multisig-sm-10 | **278.86 us** | 702.10 us | 595.21 us | 837.87 us | 849.88 us | 3.31 ms | 1.74 ms | 1.68 ms | - |
| multisig-sm-2 | - | 545.42 us | - | - | - | - | - | - | - |
| multisig-sm-3 | - | 551.14 us | - | - | - | - | - | - | - |
| multisig-sm-4 | - | 550.94 us | - | - | - | - | - | - | - |
| multisig-sm-5 | - | 703.24 us | - | - | - | - | - | - | - |
| multisig-sm-6 | - | 554.27 us | - | - | - | - | - | - | - |
| multisig-sm-7 | - | 554.12 us | - | - | - | - | - | - | - |
| multisig-sm-8 | - | 556.83 us | - | - | - | - | - | - | - |
| multisig-sm-9 | - | 555.77 us | - | - | - | - | - | - | - |
| ping-pong-1 | **169.72 us** | 496.79 us | 411.45 us | 536.96 us | 564.27 us | 2.07 ms | 1.07 ms | 1.04 ms | 189.76 ms |
| ping-pong-2 | **164.04 us** | 462.47 us | 412.87 us | 539.30 us | 562.59 us | 2.06 ms | 1.07 ms | 1.04 ms | 189.49 ms |
| ping-pong_2-1 | **100.27 us** | 339.05 us | 315.09 us | 405.26 us | 426.14 us | 1.41 ms | 756.50 us | 727.90 us | 135.95 ms |
| prism-1 | **80.59 us** | 226.77 us | 175.92 us | 234.85 us | 239.84 us | 1.02 ms | 520.80 us | 508.50 us | 84.21 ms |
| prism-2 | **206.30 us** | 559.89 us | 477.77 us | 634.87 us | 677.97 us | 2.52 ms | 1.27 ms | 1.23 ms | 223.25 ms |
| prism-3 | **181.74 us** | 453.84 us | 342.60 us | 486.26 us | 510.51 us | 2.16 ms | 1.05 ms | 1.02 ms | 175.97 ms |
| pubkey-1 | **68.66 us** | 201.12 us | 163.03 us | 214.87 us | 218.68 us | 897.93 us | 440.90 us | 435.20 us | 71.82 ms |
| stablecoin_1-1 | **492.02 us** | 1.13 ms | 1.02 ms | 1.35 ms | 1.36 ms | 4.56 ms | 5.36 ms | 5.33 ms | - |
| stablecoin_1-2 | **93.46 us** | 266.40 us | 201.15 us | 270.86 us | 279.60 us | 1.20 ms | 619.10 us | 592.50 us | 94.86 ms |
| stablecoin_1-3 | **559.64 us** | 1.28 ms | 1.14 ms | 1.52 ms | 1.53 ms | 5.21 ms | 5.83 ms | 6.15 ms | - |
| stablecoin_1-4 | **101.18 us** | 279.43 us | 209.00 us | 275.81 us | 284.95 us | 1.27 ms | 648.40 us | 618.90 us | 99.64 ms |
| stablecoin_1-5 | **706.72 us** | 1.61 ms | 1.41 ms | 1.87 ms | 1.90 ms | 6.57 ms | 7.02 ms | 6.67 ms | - |
| stablecoin_1-6 | **123.13 us** | 335.73 us | 240.19 us | 327.03 us | 326.77 us | 1.53 ms | 780.40 us | 750.50 us | 116.56 ms |
| stablecoin_2-1 | **487.03 us** | 1.12 ms | 1.04 ms | 1.37 ms | 1.38 ms | 4.54 ms | 5.34 ms | 5.25 ms | - |
| stablecoin_2-2 | **93.95 us** | 266.22 us | 199.25 us | 268.91 us | 274.75 us | 1.20 ms | 612.30 us | 590.60 us | 94.59 ms |
| stablecoin_2-3 | **550.07 us** | 1.28 ms | 1.14 ms | 1.53 ms | 1.54 ms | 5.24 ms | 5.78 ms | 5.67 ms | - |
| stablecoin_2-4 | **102.12 us** | 277.22 us | 205.39 us | 273.79 us | 283.59 us | 1.28 ms | 636.00 us | 620.40 us | 99.30 ms |
| token-account-1 | **92.10 us** | 266.15 us | 218.97 us | 297.72 us | 308.66 us | 1.18 ms | 587.30 us | 568.10 us | 105.78 ms |
| token-account-2 | **161.85 us** | 402.57 us | 303.82 us | 441.00 us | 468.14 us | 1.98 ms | 914.90 us | 886.10 us | 163.31 ms |
| uniswap-1 | **193.91 us** | 461.48 us | 352.34 us | 535.73 us | 557.73 us | 2.41 ms | 1.11 ms | 1.07 ms | 209.18 ms |
| uniswap-2 | **106.93 us** | 307.46 us | 244.79 us | 332.20 us | 349.26 us | 1.38 ms | 704.00 us | 706.50 us | 115.52 ms |
| uniswap-3 | **868.66 us** | 1.74 ms | 1.37 ms | 2.02 ms | 2.07 ms | 8.84 ms | 5.14 ms | 4.97 ms | 731.93 ms |
| uniswap-4 | **159.44 us** | 427.77 us | 293.35 us | 419.74 us | 414.85 us | 1.98 ms | 1.00 ms | 975.60 us | 144.14 ms |
| uniswap-5 | **585.20 us** | 1.24 ms | 963.44 us | 1.44 ms | 1.44 ms | 6.03 ms | 3.58 ms | 3.42 ms | 507.31 ms |
| uniswap-6 | **153.67 us** | 445.85 us | 284.63 us | 397.49 us | 405.68 us | 1.90 ms | 954.50 us | 925.90 us | 140.67 ms |
| vesting-1 | **173.39 us** | 431.56 us | 344.05 us | 499.71 us | 515.67 us | 2.07 ms | 1.02 ms | 1.03 ms | 183.11 ms |

---
*Generated by [cardano-plutus-vm-benchmark](https://github.com/saib-inc/cardano-plutus-vm-benchmark)*