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

| Script | uplc-turbo (Rust) | Plutuz (Zig) | Chrysalis (C# / .NET JIT) | Chrysalis (C# / .NET AOT) | Plutigo (Go) | blaze-plutus (TypeScript / Bun JSC) | blaze-plutus (TypeScript / Node V8) | opshin (Python / CPython) | plutus-core (Haskell / GHC) |
|---|---|---|---|---|---|---|---|---|---|
| auction_1-1 | 259.40 us | 200.95 us | 281.39 us | 279.49 us | 1.09 ms | 556.60 us | 547.50 us | 90.22 ms | **85.58 us** |
| auction_1-2 | 789.73 us | 628.59 us | 894.45 us | 925.24 us | 3.59 ms | 1.78 ms | 1.75 ms | 324.21 ms | **321.53 us** |
| auction_1-3 | 752.83 us | 615.90 us | 893.44 us | 915.43 us | 3.65 ms | 1.77 ms | 1.76 ms | 324.48 ms | **313.97 us** |
| auction_1-4 | 321.99 us | 231.38 us | 315.07 us | 318.53 us | 1.37 ms | 699.80 us | 677.40 us | 105.79 ms | **110.33 us** |
| auction_2-1 | 263.47 us | 196.93 us | 262.08 us | 268.29 us | 1.09 ms | 544.60 us | 532.50 us | 90.27 ms | **85.58 us** |
| auction_2-2 | 758.33 us | 619.27 us | 886.02 us | 914.75 us | 3.62 ms | 1.74 ms | 1.75 ms | 323.44 ms | **317.53 us** |
| auction_2-3 | 945.35 us | 735.05 us | 1.15 ms | 1.12 ms | 4.65 ms | 2.22 ms | 2.20 ms | 411.94 ms | **412.29 us** |
| auction_2-4 | 763.26 us | 614.87 us | 893.15 us | 934.14 us | 3.66 ms | 1.77 ms | 1.74 ms | 326.00 ms | **309.66 us** |
| auction_2-5 | 312.30 us | 234.65 us | 315.53 us | 322.19 us | 1.39 ms | 763.00 us | 666.80 us | 108.72 ms | **109.05 us** |
| coop-1 | - | 195.73 us | 281.41 us | 275.35 us | 1.46 ms | 829.10 us | 724.50 us | 14.76 ms | **111.83 us** |
| coop-2 | - | 567.97 us | 828.16 us | 831.06 us | 4.39 ms | 2.61 ms | 2.38 ms | 34.62 ms | **367.40 us** |
| coop-3 | - | 1.40 ms | 2.50 ms | 2.68 ms | 12.04 ms | 6.07 ms | 5.87 ms | 34.48 ms | **1.08 ms** |
| coop-4 | - | 691.54 us | 1.03 ms | 1.04 ms | 5.13 ms | 2.89 ms | 2.84 ms | 38.65 ms | **483.22 us** |
| coop-5 | - | 370.05 us | 539.46 us | 539.56 us | 2.51 ms | 1.33 ms | 1.28 ms | 36.93 ms | **198.99 us** |
| coop-6 | - | 493.00 us | 737.29 us | 722.88 us | 4.03 ms | 2.11 ms | 2.06 ms | 18.06 ms | **329.54 us** |
| coop-7 | - | 265.48 us | 379.65 us | 375.51 us | 2.04 ms | 1.05 ms | 1.03 ms | 16.98 ms | **155.18 us** |
| crowdfunding-success-1 | 292.86 us | 228.90 us | 300.76 us | 314.90 us | 1.29 ms | 649.80 us | 643.70 us | 106.07 ms | **103.33 us** |
| crowdfunding-success-2 | 295.83 us | 230.23 us | 309.68 us | 320.65 us | 1.29 ms | 648.10 us | 649.20 us | 105.08 ms | **102.18 us** |
| crowdfunding-success-3 | 289.72 us | 229.88 us | 306.30 us | 316.18 us | 1.29 ms | 651.50 us | 647.40 us | 106.06 ms | **102.62 us** |
| currency-1 | 324.14 us | 259.40 us | 359.55 us | 377.94 us | 1.50 ms | 720.30 us | 703.80 us | 132.62 ms | **122.06 us** |
| escrow-redeem_1-1 | 436.67 us | 346.83 us | 484.68 us | 517.56 us | 2.06 ms | 1.01 ms | 1.07 ms | 175.12 ms | **174.20 us** |
| escrow-redeem_1-2 | 435.93 us | 347.83 us | 496.83 us | 505.71 us | 2.05 ms | 1.02 ms | 1.01 ms | 178.82 ms | **172.81 us** |
| escrow-redeem_2-1 | 491.99 us | 381.49 us | 561.93 us | 558.79 us | 2.36 ms | 1.15 ms | 1.15 ms | 208.89 ms | **202.53 us** |
| escrow-redeem_2-2 | 491.65 us | 381.13 us | 553.13 us | 562.59 us | 2.36 ms | 1.16 ms | 1.18 ms | 207.87 ms | **199.12 us** |
| escrow-redeem_2-3 | 492.62 us | 387.24 us | 545.63 us | 557.65 us | 2.40 ms | 1.16 ms | 1.20 ms | 204.37 ms | **199.89 us** |
| escrow-refund-1 | 260.20 us | 229.79 us | 287.52 us | 307.44 us | 1.06 ms | 541.20 us | 564.40 us | 95.86 ms | **75.74 us** |
| future-increase-margin-1 | 321.47 us | 265.13 us | 360.94 us | 377.11 us | 1.49 ms | 716.10 us | 690.20 us | 132.36 ms | **121.73 us** |
| future-increase-margin-2 | 620.99 us | 469.40 us | 698.49 us | 712.37 us | 3.06 ms | 1.48 ms | 1.44 ms | 262.88 ms | **263.41 us** |
| future-increase-margin-3 | 620.92 us | 471.05 us | 689.17 us | 703.29 us | 3.07 ms | 1.48 ms | 1.43 ms | 262.11 ms | **260.01 us** |
| future-increase-margin-4 | 666.98 us | 586.42 us | 777.17 us | 834.06 us | 2.98 ms | 1.47 ms | 1.41 ms | - | **244.79 us** |
| future-increase-margin-5 | 958.03 us | 859.43 us | 1.16 ms | 1.20 ms | 4.39 ms | 3.62 ms | 3.51 ms | - | **416.04 us** |
| future-pay-out-1 | 319.91 us | 255.31 us | 362.68 us | 380.52 us | 1.49 ms | 744.90 us | 718.50 us | 133.48 ms | **121.46 us** |
| future-pay-out-2 | 615.01 us | 469.07 us | 693.97 us | 704.54 us | 3.06 ms | 1.53 ms | 1.44 ms | 263.55 ms | **264.13 us** |
| future-pay-out-3 | 618.37 us | 468.99 us | 684.00 us | 712.93 us | 3.09 ms | 1.55 ms | 1.44 ms | 261.53 ms | **258.78 us** |
| future-pay-out-4 | 951.61 us | 861.99 us | 1.17 ms | 1.19 ms | 4.38 ms | 3.59 ms | 3.52 ms | - | **420.70 us** |
| future-settle-early-1 | 321.55 us | 254.13 us | 363.86 us | 389.04 us | 1.51 ms | 744.80 us | 693.10 us | 132.87 ms | **122.22 us** |
| future-settle-early-2 | 618.58 us | 461.47 us | 695.64 us | 699.65 us | 3.07 ms | 1.52 ms | 1.44 ms | 260.98 ms | **258.95 us** |
| future-settle-early-3 | 632.26 us | 471.15 us | 685.40 us | 702.78 us | 3.07 ms | 1.53 ms | 1.44 ms | 260.41 ms | **261.10 us** |
| future-settle-early-4 | 777.02 us | 694.36 us | 933.68 us | 950.41 us | 3.35 ms | 3.14 ms | 2.95 ms | - | **315.86 us** |
| game-sm-success_1-1 | 526.20 us | 462.09 us | 602.99 us | 637.57 us | 2.36 ms | 1.28 ms | 1.22 ms | 214.44 ms | **195.48 us** |
| game-sm-success_1-2 | 275.64 us | 199.27 us | 268.53 us | 275.59 us | 1.20 ms | 621.40 us | 587.80 us | 94.30 ms | **95.07 us** |
| game-sm-success_1-3 | 754.31 us | 630.19 us | 890.19 us | 905.90 us | 3.66 ms | 1.92 ms | 1.84 ms | 325.17 ms | **309.61 us** |
| game-sm-success_1-4 | 305.77 us | 225.64 us | 300.90 us | 315.52 us | 1.38 ms | 721.30 us | 685.10 us | 104.89 ms | **109.57 us** |
| game-sm-success_2-1 | 531.53 us | 463.44 us | 605.34 us | 630.91 us | 2.38 ms | 1.28 ms | 1.24 ms | 211.59 ms | **195.69 us** |
| game-sm-success_2-2 | 267.43 us | 198.84 us | 290.13 us | 273.10 us | 1.21 ms | 617.70 us | 601.00 us | 94.97 ms | **96.08 us** |
| game-sm-success_2-3 | 759.43 us | 613.57 us | 881.33 us | 927.18 us | 3.67 ms | 1.93 ms | 1.86 ms | 322.87 ms | **311.27 us** |
| game-sm-success_2-4 | 306.96 us | 221.00 us | 303.11 us | 310.42 us | 1.39 ms | 720.50 us | 710.30 us | 106.43 ms | **113.27 us** |
| game-sm-success_2-5 | 752.20 us | 611.13 us | 886.00 us | 902.35 us | 3.66 ms | 1.92 ms | 1.86 ms | 326.09 ms | **313.77 us** |
| game-sm-success_2-6 | 304.39 us | 221.06 us | 300.97 us | 313.62 us | 1.38 ms | 719.20 us | 710.60 us | 105.79 ms | **110.72 us** |
| guardrail-sorted-large | - | 322.78 us | 519.23 us | 540.63 us | 2.80 ms | 1.49 ms | 1.46 ms | 19.82 ms | **215.04 us** |
| guardrail-sorted-small | - | 93.19 us | 128.83 us | 147.62 us | 469.62 us | 275.20 us | 263.70 us | 15.31 ms | **32.73 us** |
| guardrail-unsorted-large | - | 414.24 us | 695.41 us | 710.78 us | 3.63 ms | 1.98 ms | 1.79 ms | 19.80 ms | **294.34 us** |
| guardrail-unsorted-small | - | 91.07 us | 130.45 us | 148.66 us | 460.81 us | 268.70 us | 265.90 us | 15.49 ms | **32.56 us** |
| multisig-sm-01 | - | 487.82 us | 655.41 us | 686.88 us | 2.47 ms | 1.34 ms | 1.30 ms | - | **203.45 us** |
| multisig-sm-02 | - | 490.20 us | 638.50 us | 663.04 us | 2.41 ms | 1.31 ms | 1.27 ms | - | **200.80 us** |
| multisig-sm-03 | - | 485.34 us | 642.96 us | 669.88 us | 2.41 ms | 1.34 ms | 1.27 ms | - | **196.29 us** |
| multisig-sm-04 | - | 486.46 us | 655.26 us | 680.72 us | 2.42 ms | 1.37 ms | 1.28 ms | - | **201.24 us** |
| multisig-sm-05 | - | 594.54 us | 843.42 us | 860.71 us | 3.28 ms | 1.75 ms | 1.66 ms | - | **286.62 us** |
| multisig-sm-06 | - | 490.62 us | 652.65 us | 690.27 us | 2.44 ms | 1.34 ms | 1.29 ms | - | **200.41 us** |
| multisig-sm-07 | - | 484.40 us | 635.13 us | 666.57 us | 2.40 ms | 1.37 ms | 1.25 ms | - | **194.75 us** |
| multisig-sm-08 | - | 484.56 us | 638.77 us | 677.87 us | 2.42 ms | 1.33 ms | 1.28 ms | - | **198.89 us** |
| multisig-sm-09 | - | 496.48 us | 647.63 us | 681.63 us | 2.44 ms | 1.32 ms | 1.28 ms | - | **200.75 us** |
| multisig-sm-1 | 558.89 us | - | - | - | - | - | - | - | - |
| multisig-sm-10 | 702.10 us | 595.21 us | 837.87 us | 849.88 us | 3.31 ms | 1.74 ms | 1.68 ms | - | **278.86 us** |
| multisig-sm-2 | 545.42 us | - | - | - | - | - | - | - | - |
| multisig-sm-3 | 551.14 us | - | - | - | - | - | - | - | - |
| multisig-sm-4 | 550.94 us | - | - | - | - | - | - | - | - |
| multisig-sm-5 | 703.24 us | - | - | - | - | - | - | - | - |
| multisig-sm-6 | 554.27 us | - | - | - | - | - | - | - | - |
| multisig-sm-7 | 554.12 us | - | - | - | - | - | - | - | - |
| multisig-sm-8 | 556.83 us | - | - | - | - | - | - | - | - |
| multisig-sm-9 | 555.77 us | - | - | - | - | - | - | - | - |
| ping-pong-1 | 496.79 us | 411.45 us | 536.96 us | 564.27 us | 2.07 ms | 1.07 ms | 1.04 ms | 189.76 ms | **169.72 us** |
| ping-pong-2 | 462.47 us | 412.87 us | 539.30 us | 562.59 us | 2.06 ms | 1.07 ms | 1.04 ms | 189.49 ms | **164.04 us** |
| ping-pong_2-1 | 339.05 us | 315.09 us | 405.26 us | 426.14 us | 1.41 ms | 756.50 us | 727.90 us | 135.95 ms | **100.27 us** |
| prism-1 | 226.77 us | 175.92 us | 234.85 us | 239.84 us | 1.02 ms | 520.80 us | 508.50 us | 84.21 ms | **80.59 us** |
| prism-2 | 559.89 us | 477.77 us | 634.87 us | 677.97 us | 2.52 ms | 1.27 ms | 1.23 ms | 223.25 ms | **206.30 us** |
| prism-3 | 453.84 us | 342.60 us | 486.26 us | 510.51 us | 2.16 ms | 1.05 ms | 1.02 ms | 175.97 ms | **181.74 us** |
| pubkey-1 | 201.12 us | 163.03 us | 214.87 us | 218.68 us | 897.93 us | 440.90 us | 435.20 us | 71.82 ms | **68.66 us** |
| stablecoin_1-1 | 1.13 ms | 1.02 ms | 1.35 ms | 1.36 ms | 4.56 ms | 5.36 ms | 5.33 ms | - | **492.02 us** |
| stablecoin_1-2 | 266.40 us | 201.15 us | 270.86 us | 279.60 us | 1.20 ms | 619.10 us | 592.50 us | 94.86 ms | **93.46 us** |
| stablecoin_1-3 | 1.28 ms | 1.14 ms | 1.52 ms | 1.53 ms | 5.21 ms | 5.83 ms | 6.15 ms | - | **559.64 us** |
| stablecoin_1-4 | 279.43 us | 209.00 us | 275.81 us | 284.95 us | 1.27 ms | 648.40 us | 618.90 us | 99.64 ms | **101.18 us** |
| stablecoin_1-5 | 1.61 ms | 1.41 ms | 1.87 ms | 1.90 ms | 6.57 ms | 7.02 ms | 6.67 ms | - | **706.72 us** |
| stablecoin_1-6 | 335.73 us | 240.19 us | 327.03 us | 326.77 us | 1.53 ms | 780.40 us | 750.50 us | 116.56 ms | **123.13 us** |
| stablecoin_2-1 | 1.12 ms | 1.04 ms | 1.37 ms | 1.38 ms | 4.54 ms | 5.34 ms | 5.25 ms | - | **487.03 us** |
| stablecoin_2-2 | 266.22 us | 199.25 us | 268.91 us | 274.75 us | 1.20 ms | 612.30 us | 590.60 us | 94.59 ms | **93.95 us** |
| stablecoin_2-3 | 1.28 ms | 1.14 ms | 1.53 ms | 1.54 ms | 5.24 ms | 5.78 ms | 5.67 ms | - | **550.07 us** |
| stablecoin_2-4 | 277.22 us | 205.39 us | 273.79 us | 283.59 us | 1.28 ms | 636.00 us | 620.40 us | 99.30 ms | **102.12 us** |
| token-account-1 | 266.15 us | 218.97 us | 297.72 us | 308.66 us | 1.18 ms | 587.30 us | 568.10 us | 105.78 ms | **92.10 us** |
| token-account-2 | 402.57 us | 303.82 us | 441.00 us | 468.14 us | 1.98 ms | 914.90 us | 886.10 us | 163.31 ms | **161.85 us** |
| uniswap-1 | 461.48 us | 352.34 us | 535.73 us | 557.73 us | 2.41 ms | 1.11 ms | 1.07 ms | 209.18 ms | **193.91 us** |
| uniswap-2 | 307.46 us | 244.79 us | 332.20 us | 349.26 us | 1.38 ms | 704.00 us | 706.50 us | 115.52 ms | **106.93 us** |
| uniswap-3 | 1.74 ms | 1.37 ms | 2.02 ms | 2.07 ms | 8.84 ms | 5.14 ms | 4.97 ms | 731.93 ms | **868.66 us** |
| uniswap-4 | 427.77 us | 293.35 us | 419.74 us | 414.85 us | 1.98 ms | 1.00 ms | 975.60 us | 144.14 ms | **159.44 us** |
| uniswap-5 | 1.24 ms | 963.44 us | 1.44 ms | 1.44 ms | 6.03 ms | 3.58 ms | 3.42 ms | 507.31 ms | **585.20 us** |
| uniswap-6 | 445.85 us | 284.63 us | 397.49 us | 405.68 us | 1.90 ms | 954.50 us | 925.90 us | 140.67 ms | **153.67 us** |
| vesting-1 | 431.56 us | 344.05 us | 499.71 us | 515.67 us | 2.07 ms | 1.02 ms | 1.03 ms | 183.11 ms | **173.39 us** |

---
*Generated by [cardano-plutus-vm-benchmark](https://github.com/saib-inc/cardano-plutus-vm-benchmark)*