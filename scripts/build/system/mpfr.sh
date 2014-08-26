VERSION=${VERSION-3.1.1}

wget --no-check-certificate "http://www.mpfr.org/mpfr-$VERSION/mpfr-$VERSION.tar.xz"
rm -rf mpfr-$VERSION && tar -Jxf "mpfr-$VERSION.tar.xz"
rm -f "mpfr-$VERSION.tar.xz"
cd mpfr-$VERSION

./configure --prefix=/usr --enable-thread-safe\
    --docdir=/usr/share/doc/mpfr-$VERSION

make
make check
make install
make html
make install-html
