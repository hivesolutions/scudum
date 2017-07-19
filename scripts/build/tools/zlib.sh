VERSION=${VERSION-1.2.11}

set -e +h

wget --no-check-certificate "http://zlib.net/fossils/zlib-$VERSION.tar.gz"
rm -rf zlib-$VERSION && tar -zxf "zlib-$VERSION.tar.gz"
rm -f "zlib-$VERSION.tar.gz"
cd zlib-$VERSION

./configure --prefix=$PREFIX

make && make install
