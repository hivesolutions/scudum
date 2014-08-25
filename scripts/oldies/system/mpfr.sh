VERSION="3.1.1"
tar -Jxf "mpfr-$VERSION.tar.xz"
cd mpfr-$VERSION

./configure --prefix=/usr --enable-thread-safe\
    --docdir=/usr/share/doc/mpfr-3.1.1
make
make check
make install
make html
make install-html

cd ..
rm -rf mpfr-$VERSION
