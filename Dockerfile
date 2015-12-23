FROM ubuntu:latest
MAINTAINER Hive Solutions

ADD . /scudum

CMD /scudum/scripts/scudum root
