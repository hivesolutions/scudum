VERSION="1.2.7"
tar -jxf "zlib-$VERSION.tar.bz2"
cd zlib-$VERSION

./configure --prefix=/usr
make && make install

cd ..
rm -rf zlib-$VERSION
