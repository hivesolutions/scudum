VERSION=${VERSION-1.60}

set -e +h

wget --no-check-certificate "http://prdownloads.sourceforge.net/net-tools/net-tools-$VERSION.tar.bz2"
rm -rf net-tools-$VERSION && tar -zxf "net-tools-$VERSION.tar.bz2"
rm -f "net-tools-$VERSION.tar.gz"
cd net-tools-$VERSION

./configure --prefix=/usr

make && make install
