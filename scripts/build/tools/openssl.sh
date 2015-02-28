VERSION=${VERSION-1.0.1l}

set -e +h

unset MAKEFLAGS

wget "https://www.openssl.org/source/openssl-$VERSION.tar.gz"
rm -rf openssl-$VERSION && tar -zxf "openssl-$VERSION.tar.gz"
rm -f "openssl-$VERSION.tar.gz"
cd openssl-$VERSION

./config shared --prefix=$PREFIX --openssldir=$PREFIX/ssl
make && make install

rm -rf $PREFIX/ssl/certs
ln -svf /usr/ssl/certs $PREFIX/ssl/certs
