VERSION=${VERSION-1.18.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/automake/$VERSION/automake-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/automake/automake-$VERSION.tar.xz"
rm -rf automake-$VERSION && tar -Jxf "automake-$VERSION.tar.xz"
rm -f "automake-$VERSION.tar.xz"
cd automake-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr --docdir=/usr/share/doc/automake-$VERSION

make
test $TEST && make check
make install
