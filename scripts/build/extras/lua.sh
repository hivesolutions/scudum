VERSION=${VERSION-5.3.0}
VERSION_L=${VERSION_L-5.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://www.lua.org/ftp/lua-$VERSION.tar.gz"
rm -rf lua-$VERSION && tar -zxf "lua-$VERSION.tar.gz"
rm -f "lua-$VERSION.tar.gz"
cd lua-$VERSION

http://www.linuxfromscratch.org/patches/blfs/svn/lua-$VERSION-shared_library-1.patch
patch -Np1 -i lua-$VERSION-shared_library-1.patch

make linux
make linux install\
    INSTALL_TOP=$PREFIX\
    TO_LIB="liblua.so liblua.so.$VERSION_L liblua.so.$VERSION"
