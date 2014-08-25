VERSION=${VERSION-3.82}

wget -q "http://ftp.gnu.org/gnu/make/make-$VERSION.tar.bz2"
tar -jxf "make-$VERSION.tar.bz2"
rm -f "make-$VERSION.tar.bz2"
cd make-$VERSION

./configure --prefix=$PREFIX
make && make install
