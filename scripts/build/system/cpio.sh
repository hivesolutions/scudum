VERSION=${VERSION-2.10}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/cpio/cpio-$VERSION.tar.gz"
rm -rf cpio-$VERSION && tar -zxf "cpio-$VERSION.tar.gz"
rm -f "cpio-$VERSION.tar.gz"
cd cpio-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr

make && make install
