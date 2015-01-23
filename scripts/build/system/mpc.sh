VERSION=${VERSION-1.0.2}

set -e +h

wget --no-check-certificate "http://www.multiprecision.org/mpc/download/mpc-$VERSION.tar.gz"
rm -rf mpc-$VERSION && tar -zxf "mpc-$VERSION.tar.gz"
rm -f "mpc-$VERSION.tar.gz"
cd mpc-$VERSION

export CFLAGS="$CFLAGS -pedantic -fomit-frame-pointer"

./configure --prefix=/usr

make
test $TEST && make check
make install
