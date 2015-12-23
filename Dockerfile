FROM ubuntu:latest
MAINTAINER Hive Solutions

ADD . /scudum

CMD apt-get update && /scudum/scripts/scudum root
