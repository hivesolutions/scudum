VERSION="1.0.1"
tar -zxf "sed-$VERSION.tar.gz"
cd mpc-$VERSION

./configure --prefix=/usr

make
test $TEST && make check
make install

cd ..
rm -rf mpc-$VERSION
