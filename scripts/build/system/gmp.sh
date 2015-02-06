VERSION=${VERSION-6.0.0}

set -e +h

export CFLAGS="$CFLAGS -O2 -pedantic -fomit-frame-pointer -march=$SCUDUM_MARCH -mtune=generic"
export GMP_CPU_TYPE="$SCUDUM_MARCH"

wget --no-check-certificate "https://gmplib.org/download/gmp/gmp-$VERSION.tar.xz"
rm -rf gmp-$VERSION && tar -Jxf "gmp-$VERSION.tar.xz"
rm -f "gmp-$VERSION.tar.xz"
cd gmp-$VERSION

./configure --prefix=/usr --enable-cxx\
    --enable-fake-cpuid --docdir=/usr/share/doc/gmp-$VERSION

make

if [ $TEST ]; then
    make check 2>&1 | tee gmp-check-log
    awk '/tests passed/{total+=$2} ; END{print total}' gmp-check-log
fi

make install
