VERSION=${VERSION-3.82}

wget --no-check-certificate "http://ftp.gnu.org/gnu/make/make-$VERSION.tar.bz2"
rm -rf make-$VERSION && tar -jxf "make-$VERSION.tar.bz2"
rm -f "make-$VERSION.tar.bz2"
cd make-$VERSION

patch -Np1 -i ../make-$VERSION-upstream_fixes-3.patch

./configure --prefix=/usr

make
test $TEST && make check
make install
