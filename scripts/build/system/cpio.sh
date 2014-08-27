VERSION=${VERSION-2.11}

set -e

wget --no-check-certificate "http://ftp.gnu.org/gnu/cpio/cpio-$VERSION.tar.gz"
rm -rf "cpio-$VERSION" && tar -zxf "cpio-$VERSION.tar.gz"
rm -f "cpio-$VERSION.tar.gz"
cd cpio-$VERSION

./configure --prefix=/usr --bindir=/bin --enable-mt -with-rmt=/usr/libexec/rmt 
make && make install
