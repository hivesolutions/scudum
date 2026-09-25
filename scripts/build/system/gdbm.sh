VERSION=${VERSION-1.26}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/gdbm/$VERSION/gdbm-$VERSION.tar.gz"\
    "https://ftpmirror.gnu.org/gdbm/gdbm-$VERSION.tar.gz"
rm -rf gdbm-$VERSION && tar -zxf "gdbm-$VERSION.tar.gz"
rm -f "gdbm-$VERSION.tar.gz"
cd gdbm-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --disable-static\
    --enable-libgdbm-compat

make
test $TEST && make check
make install
