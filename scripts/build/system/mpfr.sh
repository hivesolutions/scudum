VERSION=${VERSION-3.1.2}

set -e +h

wget --no-check-certificate "http://www.mpfr.org/mpfr-$VERSION/mpfr-$VERSION.tar.xz"
rm -rf mpfr-$VERSION && tar -Jxf "mpfr-$VERSION.tar.xz"
rm -f "mpfr-$VERSION.tar.xz"
cd mpfr-$VERSION

export CFLAGS="$CFLAGS -O2 -pedantic -fomit-frame-pointer"

./configure --prefix=/usr --enable-thread-safe\
    --docdir=/usr/share/doc/mpfr-$VERSION

make
test $TEST && make check
make install
make html
make install-html
