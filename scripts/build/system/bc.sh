VERSION=${VERSION-7.0.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/bc/$VERSION/bc-$VERSION.tar.xz"\
    "https://github.com/gavinhoward/bc/releases/download/$VERSION/bc-$VERSION.tar.xz"
rm -rf bc-$VERSION && tar -Jxf "bc-$VERSION.tar.xz"
rm -f "bc-$VERSION.tar.xz"
cd bc-$VERSION

if [ "$SCUDUM_CROSS" == "1" ]; then
    CC="$ARCH_TARGET-gcc" CFLAGS="$CROSSFLAGS $EFLAGS --sysroot=/ -std=c99"\
        HOSTCFLAGS="-std=c99" ./configure\
        --prefix=/usr\
        -G\
        -O3\
        -r
else
    CC="${CC:-gcc} -std=c99" ./configure\
        --prefix=/usr\
        -G\
        -O3\
        -r
fi

make && make install
