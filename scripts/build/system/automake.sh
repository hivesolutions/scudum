VERSION=${VERSION-1.15}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/automake/automake-$VERSION.tar.xz"
rm -rf automake-$VERSION && tar -Jxf "automake-$VERSION.tar.xz"
rm -f "automake-$VERSION.tar.xz"
cd automake-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr --docdir=/usr/share/doc/automake-$VERSION

make
test $TEST && make check
make install

if [ "$SCUDUM_CROSS" == "1" ]; then
    sed -i 's/\/tools\/bin/\/usr\/bin/' /usr/bin/{aclocal,automake}
fi
