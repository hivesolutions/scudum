VERSION=${VERSION-0.177}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget --content-disposition "https://sourceware.org/elfutils/ftp/$VERSION/elfutils-$VERSION.tar.bz2"
rm -rf elfutils-$VERSION && tar -jxf "elfutils-$VERSION.tar.bz2"
rm -f "elfutils-$VERSION.tar.bz2"
cd elfutils-$VERSION

./configure --prefix=$PREFIX
make && make install
