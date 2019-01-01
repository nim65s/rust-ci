FROM rust:slim

ENV KCOV_VERSION=36

ADD https://github.com/SimonKagstrom/kcov/archive/v${KCOV_VERSION}.tar.gz /

RUN apt-get update -qqy \
 && apt-get install -qqy \
    binutils-dev \
    cmake \
    g++ \
    jq \
    libcurl4-openssl-dev \
    libdw-dev \
    libelf-dev \
    libiberty-dev \
    pkg-config \
    python \
    zlib1g-dev \
 && tar xf v${KCOV_VERSION}.tar.gz \
 && cd kcov-${KCOV_VERSION} \
 && cmake -DCMAKE_INSTALL_PREFIX=${CARGO_HOME} . \
 && make install \
 && apt-get purge -qqy \
    binutils-dev \
    build-essential \
    cmake \
    libiberty-dev \
    python \
    zlib1g-dev \
 && apt-get autoremove -qqy \
 && apt-get autoclean -qqy \
 && cd \
 && rm -rf \
    /var/lib/apt/lists/* \
    kcov-${KCOV_VERSION} \
 && rustup component add \
    clippy \
    rustfmt \
 && cargo install \
    cargo-kcov \
 && rustup default nightly
