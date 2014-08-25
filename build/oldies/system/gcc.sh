VERSION="4.7.2"
tar -jxf "gcc-$VERSION.tar.bz2"
cd gcc-$VERSION

sed -i 's/install_to_$(INSTALL_DEST) //' libiberty/Makefile.in
sed -i 's/BUILD_INFO=info/BUILD_INFO=/' gcc/configure

case `uname -m` in
  i?86) sed -i 's/^T_CFLAGS =$/& -fomit-frame-pointer/' gcc/Makefile.in ;;
esac

sed -i -e /autogen/d -e /check.sh/d fixincludes/Makefile.in

mkdir -v ../gcc-build
cd ../gcc-build

../gcc-$VERSION/configure\
    --prefix=/usr\
    --libexecdir=/usr/lib\
    --enable-shared\
    --enable-threads=posix\
    --enable-__cxa_atexit\
    --enable-clocale=gnu\
    --enable-languages=c,c++\
    --disable-multilib\
    --disable-bootstrap\
    --with-system-zlib
make && make install

ln -sv ../usr/bin/cpp /lib
ln -sv gcc /usr/bin/cc

mkdir -pv /usr/share/gdb/auto-load/usr/lib
mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib

cd ..
rm -rf gcc-build
rm -rf gcc-$VERSION
