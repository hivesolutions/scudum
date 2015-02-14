VERSION=${VERSION-0.9.14}

set -e +h

wget "http://sourceforge.net/projects/check/files/check/$VERSION/check-$VERSION.tar.gz"
rm -f "check-$VERSION" && tar -zxf "check-$VERSION.tar.gz"
rm -f "check-$VERSION.tar.gz"
cd check-$VERSION

PKG_CONFIG= ./configure --host=$ARCH_TARGET --prefix=$PREFIX
make && make install
