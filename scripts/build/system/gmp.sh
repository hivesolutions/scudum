VERSION=${VERSION-6.3.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

if [ "$SCUDUM_ARCH" == "x86_64" ]; then
    args="--enable-fat"
fi

rgeti "https://mirrors.hive.pt/mirrors/scudum/gmp/$VERSION/gmp-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/gmp/gmp-$VERSION.tar.xz"
rm -rf gmp-$VERSION && tar -Jxf "gmp-$VERSION.tar.xz"
rm -f "gmp-$VERSION.tar.xz"
cd gmp-$VERSION

sed -i '/long long t1;/,+1s/()/(...)/' configure

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --enable-cxx\
    --disable-static\
    --docdir=/usr/share/doc/gmp-$VERSION\
    $args

make
make html

if [ $TEST ]; then
    make check 2>&1 | tee gmp-check-log
    awk '/# PASS:/{total+=$3} ; END{print total}' gmp-check-log
fi

make install
make install-html
