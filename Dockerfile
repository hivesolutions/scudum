FROM hivesolutions/ubuntu:rolling
MAINTAINER Hive Solutions

VOLUME /mnt/builds

ADD . /builder

WORKDIR /build

RUN apt-get update && apt-get install -y -q make
RUN cd /builder && make install

CMD ["/builder/build.sh"]
