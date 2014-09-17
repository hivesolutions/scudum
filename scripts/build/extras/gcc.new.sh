VERSION=${VERSION-4.9.1}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/gcc/gcc-$VERSION/gcc-$VERSION.tar.bz2"
rm -rf gcc-$VERSION && tar -jxf "gcc-$VERSION.tar.bz2"
rm -f "gcc-$VERSION.tar.bz2"
cd gcc-$VERSION

cd ..
rm -rf gcc-build && mkdir gcc-build
cd gcc-build

../gcc-$VERSION/configure\
    --prefix=$PREFIX\
    --enable-languages=c,c++\
    --disable-multilib\
    --disable-bootstrap\
    --with-system-zlib

make
make install

ln -sv ..$PREFIX/bin/cpp /lib
ln -sv gcc $PREFIX/bin/cc

mkdir -pv $PREFIX/share/gdb/auto-load/usr/lib
mv -v $PREFIX/lib/*gdb.py $PREFIX/share/gdb/auto-load/usr/lib
