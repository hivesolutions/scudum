#!/bin/bash
# -*- coding: utf-8 -*-

NAME=${NAME-scudum}
DOCKER_USER=${DOCKER_USER-hivesolutions}
LOADER=${LOADER-isolinux}
SCHEMA=${SCHEMA-transient}
KVARIANT=${KVARIANT-basic}
CONFIG=${CONFIG-1}
CLEANUP=${CLEANUP-1}
DEPLOY=${DEPLOY-0}
BKERNEL=${BKERNEL-0}
BINIT=${BINIT-0}
BINITRD=${BINITRD-0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/base/config.sh

DISTRIB=${DISTRIB-$(cat $SCUDUM/etc/scudum/DISTRIB)}

if [ "$DISTRIB" == "generic" ]; then
    FILE=${FILE-$NAME:$VERSION}
else
    FILE=${FILE-$NAME:$DISTRIB-$VERSION}
fi

if type apt-get &> /dev/null; then
    apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    apt-get -y install docker-ce
elif type scu &> /dev/null; then
    env -u VERSION scu install docker
else
    exit 1
fi

if [ "$CONFIG" == "1" ]; then
    SCHEMA=$SCHEMA KVARIANT=$KVARIANT BKERNEL=$BKERNEL BINIT=$BINIT BINITRD=$BINITRD $DIR/config.sh
fi

if [ ! -e $SCUDUM/etc/scudum/CONFIGURED ]; then
    echo "make.docker: scudum not configured, not possible to make docker"
    exit 1
fi

if [ "$CLEANUP" == "1" ]; then
    $DIR/cleanup.sh
fi

tar -C $SCUDUM -c . | docker import - $DOCKER_USER/$FILE

if [ "$DEPLOY" == "1" ]; then
    docker push $DOCKER_USER/$FILE
fi
