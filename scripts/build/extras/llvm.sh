VERSION=${VERSION-3.5.0}
VERSION_M=${VERSION_M-3.5}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://llvm.org/releases/$VERSION/llvm-$VERSION.src.tar.xz"
rm -rf llvm-$VERSION && tar -Jxf "llvm-$VERSION.src.tar.xz"
rm -f "llvm-$VERSION.src.tar.xz"
cd llvm-$VERSION.src

wget "http://llvm.org/releases/$VERSION/cfe-$VERSION.src.tar.xz"
rm -rf tools && tar -Jxf "cfe-$VERSION.src.tar.xz" -C tools
mv tools/cfe-$VERSION.src tools/clang

wget "http://llvm.org/releases/$VERSION_M/compiler-rt-$VERSION_M.src.tar.xz"
rm -rf projects && tar -Jxf "compiler-rt-$VERSION_M.src.tar.xz" -C projects
mv projects/compiler-rt-$VERSION_M projects/compiler-rt

sed -e 's:/docs/llvm:/share/doc/llvm-$VERSION:'\
    -i Makefile.config.in

CC=gcc CXX=g++ ./configure\
    --prefix=$PREFIX\
    --sysconfdir=/etc\
    --enable-optimized\
    --enable-shared\
    --disable-assertions

make && make install

for file in $PREFIX/lib/lib{clang,LLVM,LTO}*.a; do
    test -f $file && chmod -v 644 $file
done
