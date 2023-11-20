FROM rust:latest
WORKDIR /usr/src/app
RUN adduser homer_simpson --system
COPY Cargo.toml Cargo.lock ./
COPY src/ ./src
RUN cargo build --release
USER homer_simpson

CMD ./target/release/DevOps