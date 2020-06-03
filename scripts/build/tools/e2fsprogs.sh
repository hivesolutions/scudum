[ "$SCUDUM_CROSS" == "0" ] && exit 0 || true

VERSION=${VERSION-1.44.4}

set -e +h

wget "http://netcologne.dl.sourceforge.net/project/e2fsprogs/e2fsprogs-$VERSION.tar.gz"
rm -rf e2fsprogs-$VERSION && tar -zxf "e2fsprogs-$VERSION.tar.gz"
rm -f "e2fsprogs-$VERSION.tar.gz"
cd e2fsprogs-$VERSION

mkdir -v build
cd build

../configure\
    --prefix=$PREFIX\
    --bindir=$PREFIX/bin\
    --sbindir=$PREFIX/sbin\
    --libdir=$PREFIX/lib\
    --with-root-prefix=""\
    --enable-elf-shlibs\
    --disable-libblkid\
    --disable-libuuid\
    --disable-uuidd\
    --disable-fsck

make
make install
make install-libs
