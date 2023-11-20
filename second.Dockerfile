FROM rust:latest
WORKDIR /usr/src/app
COPY Cargo.toml Cargo.lock ./
COPY src/ ./src
ENV RUSTFLAGS='-C target-feature=+crt-static'
RUN cargo build --release

FROM alpine:latest
WORKDIR /usr/src/app
COPY --from=0 /usr/src/app/target/release/DevOps /usr/src/app/target/release/DevOps
RUN adduser homer_simpson --system
RUN chown -R homer_simpson /usr/src/app
USER homer_simpson 

CMD /usr/src/app/target/release/DevOps