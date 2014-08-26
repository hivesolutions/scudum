VERSION=${VERSION-0.9.9}

set -e

wget "http://sourceforge.net/projects/check/files/check/$VERSION/check-$VERSION.tar.gz"
rm -f "check-$VERSION" && tar -zxf "check-$VERSION.tar.gz"
rm -f "check-$VERSION.tar.gz"
cd check-$VERSION

CFLAGS="-L/STAGE1/lib -lpthread" ./configure --prefix=$PREFIX
make && make install
