VERSION=${VERSION-1.9}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/gzip/gzip-$VERSION.tar.xz"
rm -rf gzip-$VERSION && tar -Jxf "gzip-$VERSION.tar.xz"
rm -f "gzip-$VERSION.tar.xz"
cd gzip-$VERSION

sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' lib/*.c
echo "#define _IO_IN_BACKUP 0x100" >> lib/stdio-impl.h

./configure --host=$ARCH_TARGET --prefix=/usr --bindir=/bin

make
test $TEST && make check
make install

mv -v /bin/{gzexe,uncompress,zcmp,zdiff,zegrep} /usr/bin
mv -v /bin/{zfgrep,zforce,zgrep,zless,zmore,znew} /usr/bin
