VERSION=${VERSION-1.1.0}

set -e +h

wget --no-check-certificate --content-disposition "http://ftp.gnu.org/gnu/mpc/mpc-$VERSION.tar.gz"
rm -rf mpc-$VERSION && tar -zxf "mpc-$VERSION.tar.gz"
rm -f "mpc-$VERSION.tar.gz"
cd mpc-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr --docdir=/usr/share/doc/mpc-$VERSION

make
test $TEST && make check
make install
