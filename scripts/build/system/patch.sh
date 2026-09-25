VERSION=${VERSION-2.8}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/patch/$VERSION/patch-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/patch/patch-$VERSION.tar.xz"
rm -rf patch-$VERSION && tar -Jxf "patch-$VERSION.tar.xz"
rm -f "patch-$VERSION.tar.xz"
cd patch-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr

make
test $TEST && make check
make install
