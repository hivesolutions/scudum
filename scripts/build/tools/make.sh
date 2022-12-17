VERSION=${VERSION-4.4}

set -e +h

wget --content-disposition "http://ftp.gnu.org/gnu/make/make-$VERSION.tar.gz"
rm -rf make-$VERSION && tar -zxf "make-$VERSION.tar.gz"
rm -f "make-$VERSION.tar.gz"
cd make-$VERSION

./configure --prefix=$PREFIX --without-guile
make && make install
