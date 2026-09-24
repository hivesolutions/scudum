VERSION=${VERSION-3.5.8}
VERSION_L=${VERSION_L-3.5}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

unset TEST

rgeti "https://mirrors.hive.pt/mirrors/scudum/openssl/$VERSION/openssl-$VERSION.tar.gz"\
    "https://github.com/openssl/openssl/releases/download/openssl-$VERSION/openssl-$VERSION.tar.gz"\
    "https://www.openssl.org/source/old/$VERSION_L/openssl-$VERSION.tar.gz"
rm -rf openssl-$VERSION && tar -zxf "openssl-$VERSION.tar.gz"
rm -f "openssl-$VERSION.tar.gz"
cd openssl-$VERSION

./config\
    --prefix=/usr\
    --openssldir=/usr/ssl\
    --libdir=lib\
    shared\
    zlib-dynamic

make && make install_sw install_ssldirs

ln -svf /usr/ssl /etc/ssl
