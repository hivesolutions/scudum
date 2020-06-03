VERSION=${VERSION-1.44.4}

set -e +h

wget --no-check-certificate "http://netcologne.dl.sourceforge.net/project/e2fsprogs/e2fsprogs-$VERSION.tar.gz"
rm -rf e2fsprogs-$VERSION && tar -zxf "e2fsprogs-$VERSION.tar.gz"
rm -f "e2fsprogs-$VERSION.tar.gz"
cd e2fsprogs-$VERSION

mkdir -v build
cd build

CFLAGS="$CFLAGS -luuid" LDFLAGS="$LDFLAGS -luuid" ../configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --with-root-prefix=""\
    --enable-elf-shlibs\
    --disable-libblkid\
    --disable-libuuid\
    --disable-uuidd\
    --disable-fsck

make
test $TEST && make check
make install
make install-libs

chmod -v u+w /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a
gunzip -v /usr/share/info/libext2fs.info.gz
install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info
