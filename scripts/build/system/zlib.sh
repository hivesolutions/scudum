VERSION=${VERSION-1.2.7}

wget -q --no-check-certificate "http://www.zlib.net/zlib-$VERSION.tar.bz2"
rm -rf zlib-$VERSION && tar -jxf "zlib-$VERSION.tar.bz2"
cd zlib-$VERSION

./configure --prefix=/usr
make && make install
