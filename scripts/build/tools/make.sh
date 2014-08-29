VERSION=${VERSION-4.0}

set -e +h

wget "http://ftp.gnu.org/gnu/make/make-$VERSION.tar.bz2"
rm -rf "make-$VERSION" && tar -jxf "make-$VERSION.tar.bz2"
rm -f "make-$VERSION.tar.bz2"
cd make-$VERSION

./configure --prefix=$PREFIX
make && make install
