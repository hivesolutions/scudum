VERSION="2.2.6"
tar -zxf "nano-$VERSION.tar.gz"
cd nano-$VERSION

./configure --prefix=/usr
make
test $TEST && make check
make install

cd ..
rm -rf nano-$VERSION
