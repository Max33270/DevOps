FROM rust:latest
WORKDIR /usr/src/app
COPY . /usr/src/app
ENV RUSTFLAGS='-C target-feature=+crt-static'
RUN cargo build --release 

FROM alpine:latest
WORKDIR /usr/src/app
RUN adduser homer_simpson --system
RUN chown -R homer_simpson /usr/src/app
COPY --from=0 /usr/src/app/target/release/DevOps /usr/src/app/target/release/DevOps
RUN chown -R homer_simpson /usr/src/app/target/release/DevOps
USER homer_simpson

CMD /usr/src/app/target/release/DevOps