VERSION=${VERSION-2.73}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/autoconf/$VERSION/autoconf-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/autoconf/autoconf-$VERSION.tar.xz"
rm -rf autoconf-$VERSION && tar -Jxf "autoconf-$VERSION.tar.xz"
rm -f "autoconf-$VERSION.tar.xz"
cd autoconf-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr

make
test $TEST && make check
make install
