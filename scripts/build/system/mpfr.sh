VERSION=${VERSION-3.1.5}

set -e +h

wget --no-check-certificate "https://ftp.gnu.org/gnu/mpfr/mpfr-$VERSION.tar.xz"
rm -rf mpfr-$VERSION && tar -Jxf "mpfr-$VERSION.tar.xz"
rm -f "mpfr-$VERSION.tar.xz"
cd mpfr-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr --enable-thread-safe\
    --docdir=/usr/share/doc/mpfr-$VERSION

make
test $TEST && make check
make install
make html
make install-html
