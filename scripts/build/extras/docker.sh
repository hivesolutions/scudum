VERSION=${VERSION-18.06.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "iptables"

wget "https://download.docker.com/linux/static/stable/x86_64/docker-$VERSION.tgz"

tar -zxf "docker-$VERSION.tgz"
rm -f "docker-$VERSION.tgz"
chmod +x docker/*
mkdir -pv $PREFIX/bin
mv -v docker/* $PREFIX/bin
