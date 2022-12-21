FROM nginx:1.20 as generator

WORKDIR /work

RUN  openssl req -x509 -sha256 -batch -nodes \
    -days 365 -newkey rsa:2048 -keyout /work/grafana.key \
    -out /work/grafana.crt && \
    chown -R 472 /work

FROM grafana/grafana:9.3.2-ubuntu

COPY --from=generator /work /etc/grafana/
ADD contrib/ /etc/grafana