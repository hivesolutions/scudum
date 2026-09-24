VERSION=${VERSION-1.47.4}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/e2fsprogs/$VERSION/e2fsprogs-$VERSION.tar.gz"\
    "https://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v$VERSION/e2fsprogs-$VERSION.tar.gz"\
    "--output-document=e2fsprogs-$VERSION.tar.gz"
rm -rf e2fsprogs-$VERSION && tar -zxf "e2fsprogs-$VERSION.tar.gz"
rm -f "e2fsprogs-$VERSION.tar.gz"
cd e2fsprogs-$VERSION

mkdir -v build
cd build

../configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --sysconfdir=/etc\
    --enable-elf-shlibs\
    --disable-libblkid\
    --disable-libuuid\
    --disable-uuidd\
    --disable-fsck

make
test $TEST && make check
make install

rm -fv /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a
gunzip -v /usr/share/info/libext2fs.info.gz
install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info

# keeps new ext4 file systems readable by older tools
sed 's/metadata_csum_seed,//' -i /etc/mke2fs.conf
