VERSION=${VERSION-1.0.2p}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

unset MAKEFLAGS TEST

rget "https://www.openssl.org/source/openssl-$VERSION.tar.gz"\
    "http://mirrors.ibiblio.org/openssl/source/openssl-$VERSION.tar.gz"
rm -rf openssl-$VERSION && tar -zxf "openssl-$VERSION.tar.gz"
rm -f "openssl-$VERSION.tar.gz"
cd openssl-$VERSION

./config shared --prefix=$PREFIX --openssldir=$PREFIX/ssl
make depend && make && make install

rm -rf $PREFIX/ssl/certs
ln -svf /usr/ssl/certs $PREFIX/ssl/certs
