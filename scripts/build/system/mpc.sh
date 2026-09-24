VERSION=${VERSION-1.4.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/mpc/$VERSION/mpc-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/mpc/mpc-$VERSION.tar.xz"
rm -rf mpc-$VERSION && tar -Jxf "mpc-$VERSION.tar.xz"
rm -f "mpc-$VERSION.tar.xz"
cd mpc-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --disable-static\
    --docdir=/usr/share/doc/mpc-$VERSION

make
make html
test $TEST && make check
make install
make install-html
