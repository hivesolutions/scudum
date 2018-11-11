VERSION=${VERSION-4.6.0}

set -e +h

wget "http://ftp.gnu.org/gnu/findutils/findutils-$VERSION.tar.gz"
rm -rf findutils-$VERSION && tar -zxf "findutils-$VERSION.tar.gz"
rm -f "findutils-$VERSION.tar.gz"
cd findutils-$VERSION

sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' gl/lib/*.c
sed -i '/unistd/a #include <sys/sysmacros.h>' gl/lib/mountlist.c
echo "#define _IO_IN_BACKUP 0x100" >> gl/lib/stdio-impl.h

./configure --prefix=$PREFIX
make && make install
