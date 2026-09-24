VERSION=${VERSION-3.5.8}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

unset TEST

rget "https://mirrors.hive.pt/mirrors/scudum/openssl/$VERSION/openssl-$VERSION.tar.gz"\
    "https://github.com/openssl/openssl/releases/download/openssl-$VERSION/openssl-$VERSION.tar.gz"\
    "https://www.openssl.org/source/openssl-$VERSION.tar.gz"
rm -rf openssl-$VERSION && tar -zxf "openssl-$VERSION.tar.gz"
rm -f "openssl-$VERSION.tar.gz"
cd openssl-$VERSION

./Configure linux-$SCUDUM_HOST\
    --prefix=/usr\
    --openssldir=/etc/ssl\
    --libdir=lib\
    --cross-compile-prefix=$SCUDUM_TARGET-\
    shared

make && make DESTDIR=$SCUDUM install_sw install_ssldirs
