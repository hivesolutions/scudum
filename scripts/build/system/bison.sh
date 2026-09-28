VERSION=${VERSION-3.8.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/bison/$VERSION/bison-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/bison/bison-$VERSION.tar.xz"
rm -rf bison-$VERSION && tar -Jxf "bison-$VERSION.tar.xz"
rm -f "bison-$VERSION.tar.xz"
cd bison-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --docdir=/usr/share/doc/bison-$VERSION

if [ "$SCUDUM_CROSS" == "1" ]; then
    sed -i "s|define M4 \"$M4\"|define M4 \"/usr/bin/m4\"|" lib/config.h
fi

make
test $TEST && make check
make install
