VERSION=${VERSION-1.25.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "https://mirrors.hive.pt/mirrors/scudum/wget/$VERSION/wget-$VERSION.tar.gz"\
    "https://ftpmirror.gnu.org/wget/wget-$VERSION.tar.gz"
rm -rf wget-$VERSION && tar -zxf "wget-$VERSION.tar.gz"
rm -f "wget-$VERSION.tar.gz"
cd wget-$VERSION

OPENSSL_CFLAGS="-I$SCUDUM/usr/include" OPENSSL_LIBS="-lssl -lcrypto" ./configure\
    --prefix=/usr\
    --host=$SCUDUM_TARGET\
    --build=$(build-aux/config.guess)\
    --sysconfdir=/etc\
    --with-ssl=openssl\
    --without-libpsl

make && make DESTDIR=$SCUDUM install
