VERSION=${VERSION-1.4.19}

set -e +h

wget --content-disposition "http://ftp.gnu.org/gnu/m4/m4-$VERSION.tar.bz2"
rm -rf m4-$VERSION && tar -jxf "m4-$VERSION.tar.bz2"
rm -f "m4-$VERSION.tar.bz2"
cd m4-$VERSION

sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' lib/*.c
echo "#define _IO_IN_BACKUP 0x100" >> lib/stdio-impl.h

./configure --prefix=$PREFIX
make && make install
