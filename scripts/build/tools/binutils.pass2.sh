VERSION=${VERSION-2.23.1}

wget -q "http://ftp.gnu.org/gnu/binutils/binutils-$VERSION.tar.bz2"
rm -rf binutils-$VERSION && tar -jxf "binutils-$VERSION.tar.bz2"
rm -f "binutils-$VERSION.tar.bz2"
cd binutils-$VERSION

CC=$SCUDUM_TARGET-gcc AR=$SCUDUM_TARGET-ar RANLIB=$SCUDUM_TARGET-ranlib ./configure\
    --prefix=/tools\
    --disable-nls\
    --with-lib-path=/tools/lib

make && make install

make -C ld clean
make -C ld LIB_PATH=/usr/lib:/lib
cp -v ld/ld-new /tools/bin
