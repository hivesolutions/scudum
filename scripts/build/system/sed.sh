VERSION=${VERSION-4.10}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/sed/$VERSION/sed-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/sed/sed-$VERSION.tar.xz"
rm -rf sed-$VERSION && tar -Jxf "sed-$VERSION.tar.xz"
rm -f "sed-$VERSION.tar.xz"
cd sed-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr

make
make html
test $TEST && make check
make install

install -d -m755 /usr/share/doc/sed-$VERSION
install -m644 doc/sed.html /usr/share/doc/sed-$VERSION
