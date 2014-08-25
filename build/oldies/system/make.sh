VERSION="3.82"
tar -jxf "make-$VERSION.tar.bz2"
cd make-$VERSION

patch -Np1 -i ../make-$VERSION-upstream_fixes-3.patch

./configure --prefix=/usr
make
test $TEST && make check
make install

cd ..
rm -rf make-$VERSION
