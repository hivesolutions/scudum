VERSION=${VERSION-19.03.15}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "iptables"

wget --content-disposition "https://download.docker.com/linux/static/stable/x86_64/docker-$VERSION.tgz"

tar -zxf "docker-$VERSION.tgz"
rm -f "docker-$VERSION.tgz"
chmod +x docker/*
mkdir -pv $PREFIX/bin
mv -v docker/* $PREFIX/bin
