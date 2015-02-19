VERSION=${VERSION-1.10}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/gdbm/gdbm-$VERSION.tar.gz"
rm -rf gdbm-$VERSION && tar -zxf "gdbm-$VERSION.tar.gz"
rm -f "gdbm-$VERSION.tar.gz"
cd gdbm-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr --enable-libgdbm-compat

make
test $TEST && make check
make install
