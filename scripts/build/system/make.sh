VERSION=${VERSION-4.4.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/make/$VERSION/make-$VERSION.tar.gz"\
    "https://ftpmirror.gnu.org/make/make-$VERSION.tar.gz"
rm -rf make-$VERSION && tar -zxf "make-$VERSION.tar.gz"
rm -f "make-$VERSION.tar.gz"
cd make-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr

make
test $TEST && make check
make install
