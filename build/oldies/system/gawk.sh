VERSION="4.0.2"
tar -Jxf "gawk-$VERSION.tar.xz"
cd gawk-$VERSION

./configure --prefix=/usr --libexecdir=/usr/lib
make
test $TEST && make check
make install

cd ..
rm -rf gawk-$VERSION
