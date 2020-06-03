VERSION=${VERSION-2.13.01}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget --content-disposition "http://www.nasm.us/pub/nasm/releasebuilds/$VERSION/nasm-$VERSION.tar.xz"
rm -rf nasm-$VERSION && tar -Jxf "nasm-$VERSION.tar.xz"
rm -f "nasm-$VERSION.tar.xz"
cd nasm-$VERSION

./configure --prefix=$PREFIX
make && make install
