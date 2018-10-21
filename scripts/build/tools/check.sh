VERSION=${VERSION-0.10.0}

set -e +h

wget "http://sourceforge.net/projects/check/files/check/$VERSION/check-$VERSION.tar.gz"
rm -rf check-$VERSION && tar -zxf "check-$VERSION.tar.gz"
rm -f "check-$VERSION.tar.gz"
cd check-$VERSION

PKG_CONFIG= ./configure --prefix=$PREFIX
make && make install
