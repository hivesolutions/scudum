FROM ubuntu:latest
MAINTAINER Hive Solutions

ADD . /builder

WORKDIR /build

RUN cd /build && make install

CMD apt-get update && scudum root
