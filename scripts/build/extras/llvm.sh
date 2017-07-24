VERSION=${VERSION-4.0.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "cmake"

wget "http://llvm.org/releases/$VERSION/llvm-$VERSION.src.tar.xz"
rm -rf llvm-$VERSION && tar -Jxf "llvm-$VERSION.src.tar.xz"
rm -f "llvm-$VERSION.src.tar.xz"
cd llvm-$VERSION.src

wget "http://llvm.org/releases/$VERSION/cfe-$VERSION.src.tar.xz"
tar -Jxf "cfe-$VERSION.src.tar.xz" -C tools
mv tools/cfe-$VERSION.src tools/clang

wget "http://llvm.org/releases/$VERSION/compiler-rt-$VERSION.src.tar.xz"
tar -Jxf "compiler-rt-$VERSION.src.tar.xz" -C projects
mv projects/compiler-rt-$VERSION.src projects/compiler-rt

mkdir -v build
cd build

CC=gcc CXX=g++ cmake\
    -DCMAKE_INSTALL_PREFIX=$PREFIX\
    -DLLVM_ENABLE_FFI=ON\
    -DCMAKE_BUILD_TYPE=Release\
    -DLLVM_BUILD_LLVM_DYLIB=ON\
    -DLLVM_TARGETS_TO_BUILD="host;AMDGPU"\
    -Wno-dev ..

make && make install
