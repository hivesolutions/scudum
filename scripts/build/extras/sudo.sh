VERSION=${VERSION-1.9.14p3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "https://www.sudo.ws/dist/sudo-$VERSION.tar.gz"\
    "http://ftp3.usa.openbsd.org/pub/sudo/sudo-$VERSION.tar.gz"
rm -rf sudo-$VERSION && tar -zxf "sudo-$VERSION.tar.gz"
rm -f "sudo-$VERSION.tar.gz"
cd sudo-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX
make && make install
