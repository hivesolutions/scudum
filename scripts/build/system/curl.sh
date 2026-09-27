VERSION=${VERSION-8.22.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/curl/$VERSION/curl-$VERSION.tar.xz"\
    "https://curl.se/download/curl-$VERSION.tar.xz"
rm -rf curl-$VERSION && tar -Jxf "curl-$VERSION.tar.xz"
rm -f "curl-$VERSION.tar.xz"
cd curl-$VERSION

if [ "$SCUDUM_CROSS" == "1" ]; then
    ./configure\
        --host=$ARCH_TARGET\
        --prefix=/usr\
        --disable-static\
        --disable-docs\
        --with-openssl\
        --without-libpsl\
        --with-ca-bundle=/usr/ssl/ca-bundle.crt
else
    ./configure\
        --host=$ARCH_TARGET\
        --prefix=/usr\
        --disable-static\
        --with-openssl\
        --without-libpsl\
        --with-ca-bundle=/usr/ssl/ca-bundle.crt
fi

make && make install
