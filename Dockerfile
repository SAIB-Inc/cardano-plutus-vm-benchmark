# cardano-plutus-vm-benchmark
# Multi-stage Dockerfile: build all VMs, single ubuntu:24.04 runtime
#
# Usage:
#   docker build -t plutus-bench .
#   docker run -v ./results:/results plutus-bench

# =============================================================================
# Build stage: Chrysalis (.NET / BenchmarkDotNet)
# =============================================================================
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build-chrysalis

ARG CHRYSALIS_REPO
ARG CHRYSALIS_SHA

RUN git clone "$CHRYSALIS_REPO" /src \
    && cd /src && git checkout "$CHRYSALIS_SHA"

WORKDIR /src
RUN dotnet restore benchmarks/PlutusBench/PlutusBench.csproj
RUN dotnet build -c Release -p:TreatWarningsAsErrors=false benchmarks/PlutusBench/PlutusBench.csproj

# =============================================================================
# Build stage: uplc-turbo (Rust / Criterion)
# =============================================================================
FROM rust:1.94-bookworm AS build-uplc-turbo

ARG UPLC_TURBO_REPO
ARG UPLC_TURBO_SHA

RUN git clone "$UPLC_TURBO_REPO" /src \
    && cd /src && git checkout "$UPLC_TURBO_SHA"

WORKDIR /src

RUN cargo build --release --bench use_cases --manifest-path crates/uplc/Cargo.toml

# =============================================================================
# Build stage: Plutigo (Go / testing.B)
# =============================================================================
FROM golang:1.26-bookworm AS build-plutigo

ARG PLUTIGO_REPO
ARG PLUTIGO_SHA

RUN git clone "$PLUTIGO_REPO" /src \
    && cd /src && git checkout "$PLUTIGO_SHA"

WORKDIR /src
RUN go mod download
RUN CGO_ENABLED=0 go test -c -o /plutigo-bench ./tests/

# =============================================================================
# Build stage: blaze-plutus (TypeScript / Vitest bench)
# =============================================================================
FROM oven/bun:1.3.10-debian AS build-blaze

ARG BLAZE_REPO
ARG BLAZE_SHA

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

RUN git clone "$BLAZE_REPO" /src \
    && cd /src && git checkout "$BLAZE_SHA"

WORKDIR /src
RUN bun install

# =============================================================================
# Build stage: Plutuz (Zig)
# =============================================================================
FROM debian:bookworm-slim AS build-plutuz

ARG PLUTUZ_REPO
ARG PLUTUZ_SHA
ARG ZIG_VERSION

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

ARG OPSHIN_REPO
ARG OPSHIN_SHA

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
# Build stage: Scalus (Scala / JVM / JMH)
# =============================================================================
FROM eclipse-temurin:21-jdk-jammy AS build-scalus

ARG SCALUS_REPO
ARG SCALUS_SHA

RUN apt-get update \
    && apt-get install -y git curl \
    && rm -rf /var/lib/apt/lists/*

# Install sbt
RUN curl -fsSL "https://github.com/sbt/sbt/releases/download/v1.10.11/sbt-1.10.11.tgz" \
    | tar -xz -C /opt \
    && ln -s /opt/sbt/bin/sbt /usr/local/bin/sbt

RUN git clone "$SCALUS_REPO" /src \
    && cd /src && git checkout "$SCALUS_SHA"

WORKDIR /src

# Pre-compile JMH benchmarks (this downloads deps + compiles everything)
RUN sbt bench/Jmh/compile

# =============================================================================
# Build stage: plutus-core / Haskell (GHC / Criterion)
# =============================================================================
FROM debian:bookworm AS build-haskell

ARG HASKELL_REPO
ARG HASKELL_SHA
ARG GHC_VERSION

ENV BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
    BOOTSTRAP_HASKELL_GHC_VERSION=${GHC_VERSION} \
    BOOTSTRAP_HASKELL_INSTALL_NO_STACK=1

RUN apt-get update \
    && apt-get install -y curl git pkg-config build-essential \
       libsodium-dev libsecp256k1-dev zlib1g-dev libgmp-dev libnuma-dev \
    && rm -rf /var/lib/apt/lists/*

# Install libblst (BLS12-381 crypto required by cardano-crypto-class)
RUN git clone --depth 1 --branch v0.3.14 https://github.com/supranational/blst.git /tmp/blst \
    && cd /tmp/blst && ./build.sh \
    && cp libblst.a /usr/local/lib/ \
    && cp bindings/blst.h bindings/blst_aux.h /usr/local/include/ \
    && mkdir -p /usr/local/lib/pkgconfig \
    && printf 'prefix=/usr/local\nlibdir=${prefix}/lib\nincludedir=${prefix}/include\nName: libblst\nVersion: 0.3.14\nDescription: BLS12-381 library\nLibs: -L${libdir} -lblst\nCflags: -I${includedir}\n' > /usr/local/lib/pkgconfig/libblst.pc \
    && rm -rf /tmp/blst

# Install GHC + cabal via ghcup
RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
ENV PATH="/root/.ghcup/bin:${PATH}"

RUN git clone "$HASKELL_REPO" /src \
    && cd /src && git checkout "$HASKELL_SHA"

WORKDIR /src

# Disable inline-r (requires libR) and cert (requires extra deps) — not needed for benchmarks
RUN sed -i 's/flags: +with-inline-r/flags: -with-inline-r/' cabal.project \
    && sed -i 's/flags: +with-cert/flags: -with-cert/' cabal.project

RUN cabal update
RUN cabal build plutus-benchmark:bench:validation -j

# =============================================================================
# Runtime stage: single ubuntu:24.04 image for all benchmarks
# =============================================================================
FROM ubuntu:24.04 AS runner

ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/root

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

# Haskell: compiled Criterion benchmark binary (data loaded from /bench/data/ at runtime)
COPY --from=build-haskell /src/dist-newstyle/build/x86_64-linux/ghc-9.6.4/plutus-benchmark-0.1.0.0/b/validation/build/validation/validation /bench/haskell/bin/validation

# Scalus: full sbt project + compiled JMH benchmarks (JMH needs sbt at runtime)
COPY --from=build-scalus /src /bench/scalus
COPY --from=build-scalus /opt/sbt /opt/sbt
COPY --from=build-scalus /root/.sbt /root/.sbt
COPY --from=build-scalus /root/.cache /root/.cache
RUN ln -sf /opt/sbt/bin/sbt /usr/local/bin/sbt

# Install JDK for Scalus + GHC runtime deps for Haskell
RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-21-jre-headless \
    libgmp10 libsodium-dev libsecp256k1-dev libstdc++6 \
    && rm -rf /var/lib/apt/lists/* \
    && ldconfig

# --- Copy benchmark data and scripts ---
COPY data/ /bench/data/
COPY scripts/ /bench/scripts/
COPY parsers/ /bench/parsers/
COPY report/ /bench/report/

RUN chmod +x /bench/scripts/*.sh

# Make everything writable so the container can run as any UID
# Delete .NET obj dirs and sbt target dirs so they get recreated as the running user
# (MSBuild and sbt need to set file attributes, which requires ownership)
RUN chmod -R 777 /bench/ /root/ \
    && find /bench/chrysalis -name obj -type d -exec rm -rf {} + 2>/dev/null; \
    find /bench/scalus -name target -type d -exec rm -rf {} + 2>/dev/null; \
    mkdir -p /src/tests && chmod 777 /src /src/tests

WORKDIR /bench
ENTRYPOINT ["/bench/scripts/run-all.sh"]
