VERSION=${VERSION-5.2.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://www.lua.org/ftp/lua-$VERSION.tar.gz"
rm -rf lua-$VERSION && tar -zxf "lua-$VERSION.tar.gz"
rm -f "lua-$VERSION.tar.gz"
cd lua-$VERSION

make linux && make linux install INSTALL_TOP=$PREFIX
