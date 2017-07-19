VERSION=${VERSION-7.54.1}

set -e +h

wget --no-check-certificate "http://curl.haxx.se/download/curl-$VERSION.tar.gz"
rm -rf curl-$VERSION && tar -zxf "curl-$VERSION.tar.gz"
rm -f "curl-$VERSION.tar.gz"
cd curl-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr --with-ca-bundle=/usr/ssl/ca-bundle.crt

make && make install
