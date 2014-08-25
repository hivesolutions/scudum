VERSION=${VERSION-4.4.2}

wget -q "http://ftp.gnu.org/gnu/findutils/findutils-$VERSION.tar.gz"
tar -zxf "findutils-$VERSION.tar.gz"
rm -f "findutils-$VERSION.tar.gz"
cd findutils-$VERSION

./configure --prefix=$PREFIX
make && make install
