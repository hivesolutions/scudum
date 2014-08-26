VERSION=${VERSION-2.7}

set -e

wget --no-check-certificate "http://ftp.gnu.org/gnu/bison/bison-$VERSION.tar.xz"
rm -rf bison-$VERSION && tar -Jxf "bison-$VERSION.tar.xz"
rm -f "bison-$VERSION.tar.xz"
cd bison-$VERSION

./configure --prefix=/usr

echo '#define YYENABLE_NLS 1' >> lib/config.h

make
test $TEST && make check
make install
