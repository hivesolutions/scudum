VERSION=${VERSION-4.11.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/findutils/$VERSION/findutils-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/findutils/findutils-$VERSION.tar.xz"
rm -rf findutils-$VERSION && tar -Jxf "findutils-$VERSION.tar.xz"
rm -f "findutils-$VERSION.tar.xz"
cd findutils-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --localstatedir=/var/lib/locate

make
test $TEST && make check
make install
