FROM rust:latest
WORKDIR /usr/src/app
RUN adduser homer_simpson --system
RUN chown -R homer_simpson /usr/src/app
COPY . .
RUN cargo build --release
USER homer_simpson

CMD ./target/release/DevOps