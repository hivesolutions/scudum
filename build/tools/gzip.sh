VERSION=${VERSION-1.5}

wget -q "http://ftp.gnu.org/gnu/gzip/gzip-$VERSION.tar.xz"
tar -Jxf "gzip-$VERSION.tar.xz"
rm -f "gzip-$VERSION.tar.xz"
cd gzip-$VERSION

./configure --prefix=$PREFIX
make && make install
