FROM ubuntu:latest
MAINTAINER Hive Solutions

ADD . /builder

WORKDIR /build

RUN apt-get update && apt-get install -y -q make
RUN cd /build && make install

CMD apt-get update && scudum root
