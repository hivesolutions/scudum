VERSION=${VERSION-1.8.10p3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://www.sudo.ws/sudo/dist/sudo-$VERSION.tar.gz"
rm -rf sudo-$VERSION && tar -zxf "sudo-$VERSION.tar.gz"
rm -f "sudo-$VERSION.tar.gz"
cd sudo-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX
make && make install
