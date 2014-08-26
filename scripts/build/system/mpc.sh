VERSION=${VERSION-1.0.1}

wget "http://www.multiprecision.org/mpc/download/mpc-$VERSION.tar.gz"
rm -rf mpc-$VERSION && tar -zxf "mpc-$VERSION.tar.gz"
rm -f "mpc-$VERSION.tar.gz"
cd mpc-$VERSION

./configure --prefix=/usr
make
make check
make install
