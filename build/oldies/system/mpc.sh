VERSION="1.0.1"
tar -zxf "sed-$VERSION.tar.gz"
cd mpc-$VERSION

./configure --prefix=/usr
make
make check
make install

cd ..
rm -rf mpc-$VERSION
