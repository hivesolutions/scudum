VERSION=${VERSION-3.2.1}

wget -q "ftp://ftp.gnutls.org/gcrypt/gnutls/v3.2/gnutls-$VERSION.tar.xz"
tar -Jxf "gnutls-$VERSION.tar.xz"
rm -f "gnutls-$VERSION.tar.xz"
cd gnutls-$VERSION

./configure --prefix=$PREFIX
make && make install
