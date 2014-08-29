VERSION=${VERSION-3080600}

set -e +h

wget --no-check-certificate "http://www.sqlite.org/2014/sqlite-autoconf-$VERSION.tar.gz"
rm -rf sqlite-autoconf-$VERSION && tar -zxf "sqlite-autoconf-$VERSION.tar.gz"
rm -f "sqlite-autoconf-$VERSION.tar.gz"
cd sqlite-autoconf-$VERSION

./configure --prefix=/usr
make && make install
