VERSION=${VERSION-3.2}

set -e

wget "http://ftp.gnu.org/gnu/diffutils/diffutils-$VERSION.tar.gz"
rm -f "diffutils-$VERSION" && tar -zxf "diffutils-$VERSION.tar.gz"
rm -f "diffutils-$VERSION.tar.gz"
cd diffutils-$VERSION

sed -i -e '/gets is a/d' lib/stdio.in.h

./configure --prefix=$PREFIX
make && make install
