VERSION=${VERSION-3.3}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/diffutils/diffutils-$VERSION.tar.gz"
rm -rf diffutils-$VERSION && tar -zxf "diffutils-$VERSION.tar.gz"
rm -f "diffutils-$VERSION.tar.gz"
cd diffutils-$VERSION

./configure --prefix=/usr

make
test $TEST && make check
make install
