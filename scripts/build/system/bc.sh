VERSION=${VERSION-1.06}

set -e

wget --no-check-certificate "http://ftp.gnu.org/gnu/bc/bc-$VERSION.tar.gz"
rm -rf "bc-$VERSION" && tar -zxf "bc-$VERSION.tar.gz"
rm -f "bc-$VERSION.tar.gz"
cd bc-$VERSION

./configure --prefix=/usr
make && make install
