FROM ubuntu:latest
MAINTAINER Hive Solutions

ADD . /builder

WORKDIR /build

CMD apt-get update && /builder/scripts/scudum root
