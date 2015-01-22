VERSION=${VERSION-3.3}

set -e +h

wget "http://ftp.gnu.org/gnu/diffutils/diffutils-$VERSION.tar.gz"
rm -f "diffutils-$VERSION" && tar -zxf "diffutils-$VERSION.tar.gz"
rm -f "diffutils-$VERSION.tar.gz"
cd diffutils-$VERSION

./configure --prefix=$PREFIX
make && make install
