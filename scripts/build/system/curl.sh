VERSION=${VERSION-7.37.1}

set -e

wget --no-check-certificate "http://curl.haxx.se/download/curl-$VERSION.tar.gz"
rm -rf "curl-$VERSION" && tar -zxf "curl-$VERSION.tar.gz"
rm -f "curl-$VERSION.tar.gz"
cd curl-$VERSION

./configure --prefix=/usr
make && make install
