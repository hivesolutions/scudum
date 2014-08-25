VERSION=${VERSION-1.0.1i}

wget -q "https://www.openssl.org/source/openssl-$VERSION.tar.gz"
tar -zxf "openssl-$VERSION.tar.gz"
rm -f "openssl-$VERSION.tar.gz"
cd openssl-$VERSION

./config --prefix=$PREFIX --openssldir=$PREFIX/ssl
make
make && make install
