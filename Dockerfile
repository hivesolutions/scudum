FROM ubuntu:latest
MAINTAINER Hive Solutions

ADD . /builder

CMD apt-get update && /builder/scripts/scudum root
