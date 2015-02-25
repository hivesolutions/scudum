VERSION=${VERSION-7.40.0}

set -e +h

wget "http://curl.haxx.se/download/curl-$VERSION.tar.gz"
rm -rf curl-$VERSION && tar -zxf "curl-$VERSION.tar.gz"
rm -f "curl-$VERSION.tar.gz"
cd curl-$VERSION

./configure --prefix=$PREFIX --with-ca-bundle=/usr/ssl/ca-bundle.crt

make && make install