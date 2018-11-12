VERSION=${VERSION-1.4.18}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/m4/m4-$VERSION.tar.bz2"
rm -rf cd m4-$VERSION && tar -jxf "m4-$VERSION.tar.bz2"
rm -f "m4-$VERSION.tar.bz2"
cd m4-$VERSION

sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' lib/*.c
echo "#define _IO_IN_BACKUP 0x100" >> lib/stdio-impl.h

./configure --host=$ARCH_TARGET --prefix=/usr

make
test $TEST && make check
make install
