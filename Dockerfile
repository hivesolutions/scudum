FROM ubuntu:latest
MAINTAINER Hive Solutions

ADD . /builder

WORKDIR /build

RUN apt-get update && apt-get install -y -q make
RUN cd /builder && make install

CMD apt-get update && scudum root
