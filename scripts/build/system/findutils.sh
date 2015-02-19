VERSION=${VERSION-4.4.2}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/findutils/findutils-$VERSION.tar.gz"
rm -rf findutils-$VERSION && tar -zxf "findutils-$VERSION.tar.gz"
rm -f "findutils-$VERSION.tar.gz"
cd findutils-$VERSION

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
