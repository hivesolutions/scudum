VERSION=${VERSION-2.6.4}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/flex/$VERSION/flex-$VERSION.tar.gz"\
    "https://github.com/westes/flex/releases/download/v$VERSION/flex-$VERSION.tar.gz"
rm -rf flex-$VERSION && tar -zxf "flex-$VERSION.tar.gz"
rm -f "flex-$VERSION.tar.gz"
cd flex-$VERSION

if [ "$SCUDUM_CROSS" == "1" ]; then
    export ac_cv_func_malloc_0_nonnull=yes
    export ac_cv_func_realloc_0_nonnull=yes
    export CFLAGS_FOR_BUILD="-g -O2 -std=gnu17"
fi

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --disable-static\
    --docdir=/usr/share/doc/flex-$VERSION

if [ "$SCUDUM_CROSS" == "1" ]; then
    sed -i "s|define M4 \"$M4\"|define M4 \"/usr/bin/m4\"|" src/config.h
fi

make
test $TEST && make check
make install

ln -svf flex /usr/bin/lex
ln -svf flex.1 /usr/share/man/man1/lex.1
