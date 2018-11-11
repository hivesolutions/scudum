VERSION=${VERSION-4.6.0}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/findutils/findutils-$VERSION.tar.gz"
rm -rf findutils-$VERSION && tar -zxf "findutils-$VERSION.tar.gz"
rm -f "findutils-$VERSION.tar.gz"
cd findutils-$VERSION

sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' gl/lib/*.c
sed -i '/unistd/a #include <sys/sysmacros.h>' gl/lib/mountlist.c
echo "#define _IO_IN_BACKUP 0x100" >> gl/lib/stdio-impl.h

gl_cv_func_wcwidth_works=yes ./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --libexecdir=/usr/lib/findutils\
    --localstatedir=/var/lib/locate

make
test $TEST && make check
make install

mv -v /usr/bin/find /bin
sed -i 's/find:=${BINDIR}/find:=\/bin/' /usr/bin/updatedb
