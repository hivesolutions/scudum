VERSION=${VERSION-1.4.21}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/m4/$VERSION/m4-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/m4/m4-$VERSION.tar.xz"
rm -rf m4-$VERSION && tar -Jxf "m4-$VERSION.tar.xz"
rm -f "m4-$VERSION.tar.xz"
cd m4-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr

make
test $TEST && make check
make install
