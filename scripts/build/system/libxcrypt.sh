VERSION=${VERSION-4.5.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/libxcrypt/$VERSION/libxcrypt-$VERSION.tar.xz"\
    "https://github.com/besser82/libxcrypt/releases/download/v$VERSION/libxcrypt-$VERSION.tar.xz"
rm -rf libxcrypt-$VERSION && tar -Jxf "libxcrypt-$VERSION.tar.xz"
rm -f "libxcrypt-$VERSION.tar.xz"
cd libxcrypt-$VERSION

sed -i '/strchr/s/const//' lib/crypt-{sm3,gost}-yescrypt.c

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --enable-hashes=strong,glibc\
    --enable-obsolete-api=no\
    --disable-static\
    --disable-failure-tokens

make && make install

# builds the glibc compatible libcrypt.so.1 for binary only applications
make distclean

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --enable-hashes=strong,glibc\
    --enable-obsolete-api=glibc\
    --disable-static\
    --disable-failure-tokens

make && cp -av --remove-destination .libs/libcrypt.so.1* /usr/lib
