FROM hivesolutions/ubuntu:rolling

LABEL maintainer="Hive Solutions <development@hive.pt>"

VOLUME /mnt/builds

ADD . /builder

WORKDIR /build

RUN apt-get update && apt-get install -y -q make
RUN cd /builder && make install

CMD ["/builder/build.sh"]
