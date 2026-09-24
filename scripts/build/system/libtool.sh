VERSION=${VERSION-2.6.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/libtool/$VERSION/libtool-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/libtool/libtool-$VERSION.tar.xz"
rm -rf libtool-$VERSION && tar -Jxf "libtool-$VERSION.tar.xz"
rm -f "libtool-$VERSION.tar.xz"
cd libtool-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr

make
test $TEST && make check
make install

rm -fv /usr/lib/libltdl.a
