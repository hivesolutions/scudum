VERSION=${VERSION-6.0.0}

set -e +h

if [ "$SCUDUM_ARCH" == "x86_64" ]; then
    args="--enable-fat"
fi

wget --no-check-certificate "https://gmplib.org/download/gmp/gmp-$VERSION.tar.xz"
rm -rf gmp-$VERSION && tar -Jxf "gmp-$VERSION.tar.xz"
rm -f "gmp-$VERSION.tar.xz"
cd gmp-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr --enable-cxx\
    --docdir=/usr/share/doc/gmp-$VERSION $args

make

if [ $TEST ]; then
    make check 2>&1 | tee gmp-check-log
    awk '/tests passed/{total+=$2} ; END{print total}' gmp-check-log
fi

make install
