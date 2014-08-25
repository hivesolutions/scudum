VERSION="5.0"
tar -Jxf "texinfo-$VERSION.tar.xz"
cd texinfo-$VERSION

./configure --prefix=/usr
make
test $TEST && make check
make install
make TEXMF=/usr/share/texmf install-tex

cd ..
rm -rf texinfo-$VERSION
