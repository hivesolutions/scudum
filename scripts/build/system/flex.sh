VERSION=${VERSION-2.6.4}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/flex/$VERSION/flex-$VERSION.tar.gz"\
    "https://github.com/westes/flex/releases/download/v$VERSION/flex-$VERSION.tar.gz"
rm -rf flex-$VERSION && tar -zxf "flex-$VERSION.tar.gz"
rm -f "flex-$VERSION.tar.gz"
cd flex-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --disable-static\
    --docdir=/usr/share/doc/flex-$VERSION

make
test $TEST && make check
make install

ln -svf flex /usr/bin/lex
ln -svf flex.1 /usr/share/man/man1/lex.1
