VERSION=${VERSION-1.0.1l}

set -e +h

unset MAKEFLAGS

wget --no-check-certificate "https://www.openssl.org/source/openssl-$VERSION.tar.gz"
rm -rf openssl-$VERSION && tar -zxf "openssl-$VERSION.tar.gz"
rm -f "openssl-$VERSION.tar.gz"
cd openssl-$VERSION

./config shared --prefix=/usr --openssldir=/usr/ssl
make && make install

ln -sv /usr/ssl /etc/ssl
