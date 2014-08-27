VERSION=${VERSION-1.0.1i}

set -e

wget "https://www.openssl.org/source/openssl-$VERSION.tar.gz"
rm -rf "openssl-$VERSION" && tar -zxf "openssl-$VERSION.tar.gz"
rm -f "openssl-$VERSION.tar.gz"
cd openssl-$VERSION

./config shared --prefix=/usr --openssldir=/usr/ssl
make && make install
