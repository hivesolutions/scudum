VERSION=${VERSION-2.69}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/autoconf/autoconf-$VERSION.tar.xz"
rm -rf autoconf-$VERSION && tar -Jxf "autoconf-$VERSION.tar.xz"
rm -f "autoconf-$VERSION.tar.xz"
cd autoconf-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr

make
test $TEST && make check
make install

sed -i 's/\/tools\/bin/\/usr\/bin/' /usr/bin/{autom4te,autoheader}
