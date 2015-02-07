VERSION=${VERSION-2.1.5}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "alsa" "ffmpeg" "liba52" "libgcrypt" "libmad" "lua-shared" "x11" "xdg-utils"

wget "http://download.videolan.org/vlc/$VERSION/vlc-$VERSION.tar.xz"
rm -rf vlc-$VERSION && tar -Jxf "vlc-$VERSION.tar.xz"
rm -f "vlc-$VERSION.tar.xz"
cd vlc-$VERSION

./bootstrap

sed "s:< 56:< 57:g" -i configure

./configure --prefix=$PREFIX --enable-run-as-root

sed -i 's/luaL_optint/(int)&eger/' modules/lua/libs/{net,osd,volume}.c
sed -i 's/luaL_checkint(/(int)luaL_checkinteger(/'\
    modules/lua/{demux,libs/{configuration,net,osd,playlist,stream,variables,volume}}.c

make && make install
