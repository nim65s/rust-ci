FROM kcov/kcov
FROM rust:slim

COPY --from=0 /lib/x86_64-linux-gnu/*.so* /lib/x86_64-linux-gnu/
COPY --from=0 /usr/lib/x86_64-linux-gnu/*.so* /usr/lib/x86_64-linux-gnu/
COPY --from=0 /usr/local/bin/kcov* $CARGO_HOME/bin/

RUN rustup default nightly \
 && rustup component add \
    clippy \
    rustfmt \
 && cargo install \
    cargo-kcov
