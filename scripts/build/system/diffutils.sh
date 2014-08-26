VERSION=${VERSION-3.2}

set -e

wget --no-check-certificate "http://ftp.gnu.org/gnu/diffutils/diffutils-$VERSION.tar.gz"
rm -rf diffutils-$VERSION && tar -zxf "diffutils-$VERSION.tar.gz"
rm -f "diffutils-$VERSION.tar.gz"
cd diffutils-$VERSION

sed -i -e '/gets is a/d' lib/stdio.in.h

./configure --prefix=/usr

make
test $TEST && make check
make install
