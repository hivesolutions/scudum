[ "$SCUDUM_CROSS" == "1" ] && exit 0 || true

VERSION=${VERSION-7.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/texinfo/$VERSION/texinfo-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/texinfo/texinfo-$VERSION.tar.xz"
rm -rf texinfo-$VERSION && tar -Jxf "texinfo-$VERSION.tar.xz"
rm -f "texinfo-$VERSION.tar.xz"
cd texinfo-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr

make
test $TEST && make check
make install
make TEXMF=/usr/share/texmf install-tex
