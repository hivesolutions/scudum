VERSION=${VERSION-5.3.0}
VERSION_L=${VERSION_L-5.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://www.lua.org/ftp/lua-$VERSION.tar.gz"
rm -rf lua-$VERSION && tar -zxf "lua-$VERSION.tar.gz"
rm -f "lua-$VERSION.tar.gz"
cd lua-$VERSION

wget http://archive.hive.pt/files/lfs/patches/lua-$VERSION-shared_library-1.patch
patch -Np1 -i lua-$VERSION-shared_library-1.patch

make linux && make linux install INSTALL_TOP=$PREFIX TO_LIB="liblua.so"

ln -sv liblua.so $PREFIX/lib/liblua.so.$VERSION_L
ln -sv liblua.so $PREFIX/lib/liblua.so.$VERSION
