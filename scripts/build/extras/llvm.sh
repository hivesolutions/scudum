VERSION=${VERSION-3.4.2}
VERSION_M=${VERSION_M-3.4}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://llvm.org/releases/$VERSION/llvm-$VERSION.src.tar.gz"
rm -rf llvm-$VERSION && tar -zxf "llvm-$VERSION.src.tar.gz"
rm -f "llvm-$VERSION.src.tar.gz"
cd llvm-$VERSION.src

wget "http://llvm.org/releases/$VERSION/cfe-$VERSION.src.tar.gz"
tar -zxf "cfe-$VERSION.src.tar.gz" -C tools
mv tools/cfe-$VERSION.src tools/clang

wget "http://llvm.org/releases/$VERSION_M/compiler-rt-$VERSION_M.src.tar.gz"
tar -zxf "compiler-rt-$VERSION_M.src.tar.gz" -C projects
mv projects/compiler-rt-$VERSION_M projects/compiler-rt

sed -e 's:/docs/llvm:/share/doc/llvm-$VERSION:'\
    -i Makefile.config.in

CC=gcc CXX=g++ ./configure --prefix=$PREFIX\
    --sysconfdir=/etc\
    --enable-optimized\
    --enable-shared\
    --disable-assertions

make && make install

for file in $PREFIX/lib/lib{clang,LLVM,LTO}*.a; do
    test -f $file && chmod -v 644 $file
done
