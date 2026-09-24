VERSION=${VERSION-1.9.17p2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "https://mirrors.hive.pt/mirrors/scudum/sudo/$VERSION/sudo-$VERSION.tar.gz"\
    "https://www.sudo.ws/dist/sudo-$VERSION.tar.gz"\
    "https://github.com/sudo-project/sudo/releases/download/v$VERSION/sudo-$VERSION.tar.gz"
rm -rf sudo-$VERSION && tar -zxf "sudo-$VERSION.tar.gz"
rm -f "sudo-$VERSION.tar.gz"
cd sudo-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX
make && make install
