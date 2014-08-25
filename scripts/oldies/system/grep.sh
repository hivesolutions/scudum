VERSION="2.14"
tar -Jxf "grep-$VERSION.tar.xz"
cd grep-$VERSION

./configure --prefix=/usr --bindir=/bin

make
make check
make install

cd ..
rm -rf grep-$VERSION
