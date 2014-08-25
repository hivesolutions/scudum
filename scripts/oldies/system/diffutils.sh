VERSION="3.2"
tar -zxf "diffutils-$VERSION.tar.gz"
cd diffutils-$VERSION

sed -i -e '/gets is a/d' lib/stdio.in.h

./configure --prefix=/usr
make
test $TEST && make check
make install

cd ..
rm -rf diffutils-$VERSION
