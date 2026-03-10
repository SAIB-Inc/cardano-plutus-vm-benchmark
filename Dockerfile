# cardano-plutus-vm-benchmark
# Multi-stage Dockerfile: build all 6 VMs, single ubuntu:24.04 runtime
#
# Usage:
#   docker build -t plutus-bench .
#   docker run -v ./results:/results plutus-bench

# =============================================================================
# Build stage: Chrysalis (.NET / BenchmarkDotNet)
# =============================================================================
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build-chrysalis

ARG CHRYSALIS_REPO=https://github.com/SAIB-Inc/Chrysalis.git
ARG CHRYSALIS_SHA=d50ae2cf7fa4e3df0cba10986908b95fe3f1714f

RUN git clone "$CHRYSALIS_REPO" /src \
    && cd /src && git checkout "$CHRYSALIS_SHA"

WORKDIR /src
RUN dotnet restore benchmarks/PlutusBench/PlutusBench.csproj
RUN dotnet build -c Release benchmarks/PlutusBench/PlutusBench.csproj

# =============================================================================
# Build stage: uplc-turbo (Rust / Criterion)
# =============================================================================
FROM rust:1.94-bookworm AS build-uplc-turbo

ARG UPLC_TURBO_REPO=https://github.com/pragma-org/uplc.git
ARG UPLC_TURBO_SHA=6152616cfb32b18c32aaaa0b0529b8711ac2fc26

RUN git clone "$UPLC_TURBO_REPO" /src \
    && cd /src && git checkout "$UPLC_TURBO_SHA"

WORKDIR /src
RUN cargo build --release --bench use_cases --manifest-path crates/uplc/Cargo.toml

# =============================================================================
# Build stage: Plutigo (Go / testing.B)
# =============================================================================
FROM golang:1.26-bookworm AS build-plutigo

ARG PLUTIGO_REPO=https://github.com/blinklabs-io/plutigo.git
ARG PLUTIGO_SHA=83aaa7cf28c5de697f6fa062361e56793766c3cc

RUN git clone "$PLUTIGO_REPO" /src \
    && cd /src && git checkout "$PLUTIGO_SHA"

WORKDIR /src
RUN go mod download
RUN CGO_ENABLED=0 go test -c -o /plutigo-bench ./tests/

# =============================================================================
# Build stage: blaze-plutus (TypeScript / Vitest bench)
# =============================================================================
FROM oven/bun:1.3.10-debian AS build-blaze

ARG BLAZE_REPO=https://github.com/butaneprotocol/blaze-cardano.git
ARG BLAZE_SHA=28367d38e18103daf9da42abce227d06486eea87

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

RUN git clone "$BLAZE_REPO" /src \
    && cd /src && git checkout "$BLAZE_SHA"

WORKDIR /src
RUN bun install

# =============================================================================
# Build stage: Plutuz (Zig)
# =============================================================================
FROM debian:bookworm-slim AS build-plutuz

ARG PLUTUZ_REPO=https://github.com/utxo-company/plutuz.git
ARG PLUTUZ_SHA=33b812dbcf88f6851286e54cb93a4a443353f94c
ARG ZIG_VERSION=0.15.2

RUN apt-get update \
    && apt-get install -y curl xz-utils git \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL "https://ziglang.org/download/${ZIG_VERSION}/zig-x86_64-linux-${ZIG_VERSION}.tar.xz" \
    | tar -xJ -C /opt \
    && ln -s /opt/zig-x86_64-linux-${ZIG_VERSION}/zig /usr/local/bin/zig

RUN git clone "$PLUTUZ_REPO" /src \
    && cd /src && git checkout "$PLUTUZ_SHA"

WORKDIR /src
# Patch build.zig to install the bench binary (upstream only has a run step)
RUN sed -i '/const run_bench = b.addRunArtifact(bench_exe);/i\    b.installArtifact(bench_exe);' build.zig
RUN zig build -Doptimize=ReleaseFast

# =============================================================================
# Build stage: opshin-uplc (Python)
# =============================================================================
FROM python:3.14-bookworm AS build-opshin

ARG OPSHIN_REPO=https://github.com/OpShin/uplc.git
ARG OPSHIN_SHA=8216a056fa8eacace597b9a335174cc054c12bbe

RUN apt-get update \
    && apt-get install -y git autoconf automake libtool \
    && rm -rf /var/lib/apt/lists/*

RUN git clone "$OPSHIN_REPO" /src \
    && cd /src && git checkout "$OPSHIN_SHA"

# Build secp256k1 from source (script uses sudo, but we're root in Docker)
RUN apt-get update && apt-get install -y sudo && rm -rf /var/lib/apt/lists/* \
    && cd /src && bash install_secp256k1.sh

WORKDIR /src
RUN pip install --no-cache-dir .

# =============================================================================
# Runtime stage: single ubuntu:24.04 image for all benchmarks
# =============================================================================
FROM ubuntu:24.04 AS runner

ENV DEBIAN_FRONTEND=noninteractive

# Install .NET SDK
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       wget apt-transport-https ca-certificates \
    && wget -q https://dot.net/v1/dotnet-install.sh -O /tmp/dotnet-install.sh \
    && chmod +x /tmp/dotnet-install.sh \
    && /tmp/dotnet-install.sh --channel 10.0 --install-dir /usr/share/dotnet \
    && ln -s /usr/share/dotnet/dotnet /usr/local/bin/dotnet \
    && rm /tmp/dotnet-install.sh

# Install Python
RUN apt-get install -y --no-install-recommends \
    python3 python3-pip python3-venv \
    && ln -sf /usr/bin/python3 /usr/bin/python

# Install Bun
RUN apt-get install -y --no-install-recommends curl unzip \
    && curl -fsSL https://bun.sh/install | bash \
    && ln -s /root/.bun/bin/bun /usr/local/bin/bun

# Install Node.js (for V8 benchmark variant)
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y --no-install-recommends nodejs

# Install ICU, NativeAOT prerequisites (clang, zlib), and utilities
RUN apt-get install -y --no-install-recommends \
    libicu-dev clang zlib1g-dev time procps \
    && rm -rf /var/lib/apt/lists/*

# Copy secp256k1 libraries from opshin build
COPY --from=build-opshin /usr/local/lib/libsecp256k1* /usr/local/lib/
RUN ldconfig

# --- Copy VM builds ---

# Chrysalis: full source + build output (BenchmarkDotNet needs project at runtime)
COPY --from=build-chrysalis /src /bench/chrysalis

# uplc-turbo: compiled bench binary + data
COPY --from=build-uplc-turbo /src/target /bench/uplc-turbo/target
COPY --from=build-uplc-turbo /src/crates/uplc/benches /bench/uplc-turbo/crates/uplc/benches
COPY --from=build-uplc-turbo /src/crates/uplc/Cargo.toml /bench/uplc-turbo/crates/uplc/Cargo.toml
COPY --from=build-uplc-turbo /src/Cargo.toml /bench/uplc-turbo/Cargo.toml
COPY --from=build-uplc-turbo /src/Cargo.lock /bench/uplc-turbo/Cargo.lock

# Plutigo: compiled test binary
COPY --from=build-plutigo /plutigo-bench /bench/plutigo/plutigo-bench

# blaze-plutus: full source + node_modules
COPY --from=build-blaze /src /bench/blaze-plutus

# Plutuz: compiled bench binary
COPY --from=build-plutuz /src/zig-out /bench/plutuz/zig-out
COPY --from=build-plutuz /src/bench /bench/plutuz/bench
COPY --from=build-plutuz /src/build.zig /bench/plutuz/build.zig

# opshin: Copy Python 3.14 runtime (Ubuntu 24.04 has 3.12, but opshin was built with 3.14)
COPY --from=build-opshin /usr/local/bin/python3.14 /usr/local/bin/python3.14
COPY --from=build-opshin /usr/local/lib/python3.14 /usr/local/lib/python3.14
COPY --from=build-opshin /usr/local/lib/libpython3.14* /usr/local/lib/
RUN ldconfig
COPY --from=build-opshin /src /bench/opshin
# Copy our benchmark script into opshin dir (not part of upstream repo)
COPY scripts/opshin_bench.py /bench/opshin/bench_plutus_use_cases.py

# --- Copy benchmark data and scripts ---
COPY data/ /bench/data/
COPY scripts/ /bench/scripts/
COPY parsers/ /bench/parsers/
COPY report/ /bench/report/

RUN chmod +x /bench/scripts/*.sh

WORKDIR /bench
ENTRYPOINT ["/bench/scripts/run-all.sh"]
