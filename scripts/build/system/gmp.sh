VERSION=${VERSION-5.1.3}

set -e

wget --no-check-certificate "ftp://ftp.gmplib.org/pub/gmp-$VERSION/gmp-$VERSION.tar.xz"
rm -rf gmp-$VERSION && tar -Jxf "gmp-$VERSION.tar.xz"
rm -f "gmp-$VERSION.tar.xz"
cd gmp-$VERSION

./configure --prefix=/usr --enable-cxx

make

if [ $TEST ]; then
    make check 2>&1 | tee gmp-check-log
    awk '/tests passed/{total+=$2} ; END{print total}' gmp-check-log
fi

make install
