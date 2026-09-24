VERSION=${VERSION-1.24.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

unset MAKEFLAGS

rgeti "https://mirrors.hive.pt/mirrors/scudum/groff/$VERSION/groff-$VERSION.tar.gz"\
    "https://ftpmirror.gnu.org/groff/groff-$VERSION.tar.gz"
rm -rf groff-$VERSION && tar -zxf "groff-$VERSION.tar.gz"
rm -f "groff-$VERSION.tar.gz"
cd groff-$VERSION

PAGE=letter ./configure --host=$ARCH_TARGET --prefix=/usr

make
make install

ln -svf eqn /usr/bin/geqn
ln -svf tbl /usr/bin/gtbl
