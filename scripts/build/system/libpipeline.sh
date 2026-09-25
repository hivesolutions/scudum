VERSION=${VERSION-1.5.8}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/libpipeline/$VERSION/libpipeline-$VERSION.tar.gz"\
    "https://download.savannah.gnu.org/releases/libpipeline/libpipeline-$VERSION.tar.gz"
rm -rf libpipeline-$VERSION && tar -zxf "libpipeline-$VERSION.tar.gz"
rm -f "libpipeline-$VERSION.tar.gz"
cd libpipeline-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr

make
test $TEST && make check
make install
