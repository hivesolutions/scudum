VERSION=${VERSION-3.8}

set -e +h

wget --content-disposition "http://ftp.gnu.org/gnu/diffutils/diffutils-$VERSION.tar.xz"
rm -rf diffutils-$VERSION && tar -Jxf "diffutils-$VERSION.tar.xz"
rm -f "diffutils-$VERSION.tar.xz"
cd diffutils-$VERSION

./configure --prefix=$PREFIX
make && make install
