VERSION="2.7.1"
tar -Jxf "patch-$VERSION.tar.xz"
cd patch-$VERSION

./configure --prefix=/usr
make
test $TEST && make check
make install

cd ..
rm -rf patch-$VERSION
