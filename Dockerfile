FROM ubuntu:focal
MAINTAINER Ashraf Sharif <ashraf@severalnines.com>

# Proxysql version, based on https://github.com/sysown/proxysql/releases
ENV VERSION 2.0.14

RUN apt-get update && \
    apt-get install -y wget mysql-client && \
    wget https://github.com/sysown/proxysql/releases/download/v${VERSION}/proxysql_${VERSION}-ubuntu20_amd64.deb -O /opt/proxysql_${VERSION}-ubuntu20_amd64.deb && \
    dpkg -i /opt/proxysql_${VERSION}-ubuntu20_amd64.deb && \
    rm -f /opt/proxysql_${VERSION}-ubuntu20_amd64.deb && \
    rm -rf /var/lib/apt/lists/*

VOLUME /var/lib/proxysql
EXPOSE 6032 6033 6080

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
