VERSION=${VERSION-1.2.7}

wget -q --no-check-certificate "http://zlib.net/fossils/zlib-$VERSION.tar.gz"
rm -rf zlib-$VERSION && tar -zxf "zlib-$VERSION.tar.gz"
cd zlib-$VERSION

./configure --prefix=/usr
make && make install
