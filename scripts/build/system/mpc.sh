VERSION=${VERSION-1.0.2}

set -e +h

export CFLAGS="$CFLAGS -O2 -pedantic -fomit-frame-pointer -march=$SCUDUM_MARCH -mtune=generic"

wget --no-check-certificate "http://www.multiprecision.org/mpc/download/mpc-$VERSION.tar.gz"
rm -rf mpc-$VERSION && tar -zxf "mpc-$VERSION.tar.gz"
rm -f "mpc-$VERSION.tar.gz"
cd mpc-$VERSION

./configure --prefix=/usr --docdir=/usr/share/doc/mpc-$VERSION

make
test $TEST && make check
make install
