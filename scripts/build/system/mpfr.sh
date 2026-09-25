VERSION=${VERSION-4.2.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/mpfr/$VERSION/mpfr-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/mpfr/mpfr-$VERSION.tar.xz"
rm -rf mpfr-$VERSION && tar -Jxf "mpfr-$VERSION.tar.xz"
rm -f "mpfr-$VERSION.tar.xz"
cd mpfr-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --disable-static\
    --enable-thread-safe\
    --docdir=/usr/share/doc/mpfr-$VERSION

make
make html
test $TEST && make check
make install
make install-html
