FROM ubuntu:latest
MAINTAINER Hive Solutions

VOLUME /mnt/builds

ADD . /builder

WORKDIR /build

RUN apt-get update && apt-get install -y -q make
RUN cd /builder && make install

CMD apt-get update && scudum root && scudum deploy
