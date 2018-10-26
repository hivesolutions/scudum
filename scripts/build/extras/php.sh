VERSION=${VERSION-5.6.38}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

unset MAKEFLAGS

if [ -z "$CFLAGS" ]; then export CFLAGS="-O2"; fi
export CFLAGS="$CFLAGS -fpic"

wget "http://php.net/get/php-$VERSION.tar.gz/from/this/mirror" "--output-document=php-$VERSION.tar.gz"
rm -rf php-$VERSION && tar -zxf "php-$VERSION.tar.gz"
rm -f "php-$VERSION.tar.gz"
cd php-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=$PREFIX\
    --enable-embed=static\
    --disable-libxml\
    --disable-dom\
    --disable-simplexml\
    --disable-xml\
    --disable-xmlreader\
    --disable-xmlwriter\
    --without-pear\
    --without-iconv

make && make install
