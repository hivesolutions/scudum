VERSION=${VERSION-10.49}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "https://mirrors.hive.pt/mirrors/scudum/pcre2/$VERSION/pcre2-$VERSION.tar.bz2"\
    "https://github.com/PCRE2Project/pcre2/releases/download/pcre2-$VERSION/pcre2-$VERSION.tar.bz2"
rm -rf pcre2-$VERSION && tar -jxf "pcre2-$VERSION.tar.bz2"
rm -f "pcre2-$VERSION.tar.bz2"
cd pcre2-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX --enable-unicode --enable-jit --disable-static
make && make install
