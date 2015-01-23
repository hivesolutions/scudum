VERSION=${VERSION-5.1.3}

set -e +h

export CFLAGS="$CFLAGS -O2 -pedantic -fomit-frame-pointer"

wget --no-check-certificate "http://ftp.gnu.org/gnu/gmp/gmp-$VERSION.tar.xz"
rm -rf gmp-$VERSION && tar -Jxf "gmp-$VERSION.tar.xz"
rm -f "gmp-$VERSION.tar.xz"
cd gmp-$VERSION

./configure --prefix=/usr --enable-cxx\
    --docdir=/usr/share/doc/gmp-$VERSION

make

if [ $TEST ]; then
    make check 2>&1 | tee gmp-check-log
    awk '/tests passed/{total+=$2} ; END{print total}' gmp-check-log
fi

make install
