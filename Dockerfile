FROM ubuntu:latest
MAINTAINER Hive Solutions

ADD . /scudum

RUN apt-get update

CMD /scudum/scripts/scudum root
