VERSION=${VERSION-1.44.4}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

wget --content-disposition "http://downloads.sourceforge.net/e2fsprogs/e2fsprogs-$VERSION.tar.gz?use_mirror=netix" CUnit-$VERSION.tar.bz2
rm -rf e2fsprogs-$VERSION && tar -zxf "e2fsprogs-$VERSION.tar.gz"
rm -f "e2fsprogs-$VERSION.tar.gz"
cd e2fsprogs-$VERSION

mkdir -v build
cd build

../configure\
    --host=$ARCH_TARGET\
    --prefix=$PREFIX\
    --with-root-prefix=""\
    --enable-elf-shlibs\
    --disable-libblkid\
    --disable-libuuid\
    --disable-uuidd\
    --disable-fsck

make
make install
make install-libs

chmod -v u+w $PREFIX/lib/{libcom_err,libe2p,libext2fs,libss}.a
gunzip -v $PREFIX/share/info/libext2fs.info.gz
install-info --dir-file=$PREFIX/share/info/dir $PREFIX/share/info/libext2fs.info
