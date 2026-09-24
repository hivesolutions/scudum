VERSION=${VERSION-$GCC_BUILD_VERSION}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "https://mirrors.hive.pt/mirrors/scudum/gcc/$VERSION/gcc-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/gcc/gcc-$VERSION/gcc-$VERSION.tar.xz"
rm -rf gcc-$VERSION && tar -Jxf "gcc-$VERSION.tar.xz"
rm -f "gcc-$VERSION.tar.xz"
cd gcc-$VERSION

cd ..
rm -rf gcc-build && mkdir gcc-build
cd gcc-build

../gcc-$VERSION/libstdc++-v3/configure\
    --host=$SCUDUM_TARGET\
    --build=$(../gcc-$VERSION/config.guess)\
    --prefix=/usr\
    --disable-multilib\
    --disable-nls\
    --disable-libstdcxx-pch\
    --with-gxx-include-dir=$PREFIX/$SCUDUM_TARGET/include/c++/$VERSION\
    CXX=$SCUDUM_TARGET-gcc

make && make DESTDIR=$SCUDUM install

rm -v $SCUDUM/usr/lib/lib{stdc++{,exp,fs},supc++}.la
