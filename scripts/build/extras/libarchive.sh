VERSION=${VERSION-3.3.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

wget --content-disposition "https://www.libarchive.org/downloads/libarchive-$VERSION.tar.gz"
rm -rf libarchive-$VERSION && tar -zxf "libarchive-$VERSION.tar.gz"
rm -f "libarchive-$VERSION.tar.gz"
cd libarchive-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX

make && make install
