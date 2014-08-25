VERSION="5.13"
tar -zxf "file-$VERSION.tar.gz"
cd file-$VERSION

./configure --prefix=/usr
make && make install

cd ..
rm -rf file-$VERSION
