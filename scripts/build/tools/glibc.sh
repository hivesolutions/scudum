VERSION=${VERSION-2.25}

set -e +h

wget "http://ftp.gnu.org/gnu/glibc/glibc-$VERSION.tar.xz"
rm -rf glibc-$VERSION && tar -Jxf "glibc-$VERSION.tar.xz"
rm -f "glibc-$VERSION.tar.xz"
cd glibc-$VERSION

cd ..
rm -rf glibc-build && mkdir glibc-build
cd glibc-build

../glibc-$VERSION/configure\
    --prefix=$PREFIX\
    --host=$SCUDUM_TARGET\
    --build=$(../glibc-$VERSION/scripts/config.guess)\
    --$GCC_MULTIARCH-multi-arch\
    --enable-kernel=2.6.32\
    --with-headers=$PREFIX/include\
    libc_cv_forced_unwind=yes\
    libc_cv_c_cleanup=yes

make && make install

echo "int main(){}" > dummy.c && $SCUDUM_TARGET-gcc dummy.c
readelf -l a.out && ./a.out && rm -v dummy.c a.out
