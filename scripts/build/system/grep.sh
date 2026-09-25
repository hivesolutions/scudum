VERSION=${VERSION-3.12}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/grep/$VERSION/grep-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/grep/grep-$VERSION.tar.xz"
rm -rf grep-$VERSION && tar -Jxf "grep-$VERSION.tar.xz"
rm -f "grep-$VERSION.tar.xz"
cd grep-$VERSION

sed -i "s/echo/#echo/" src/egrep.sh

./configure --host=$ARCH_TARGET --prefix=/usr

make
test $TEST && make check
make install
