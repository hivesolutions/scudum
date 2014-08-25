VERSION="2.7"
tar -Jxf "bison-$VERSION.tar.xz"
cd bison-$VERSION

./configure --prefix=/usr

echo '#define YYENABLE_NLS 1' >> lib/config.h

make
make check
make install

cd ..
rm -rf bison-$VERSION
