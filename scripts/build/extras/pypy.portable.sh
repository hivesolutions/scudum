VERSION=${VERSION-5.3.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "expat" "libffi" "libtinfo"

wget "https://bitbucket.org/squeaky/portable-pypy/downloads/pypy-$VERSION-linux_x86_64-portable.tar.bz2"
rm -rf pypy-$VERSION-linux_x86_64-portable && tar -jxf "pypy-$VERSION-linux_x86_64-portable.tar.bz2"

mv -v pypy-$VERSION-linux_x86_64-portable.tar.bz2 $PREFIX/lib
cd $PREFIX/lib

rm -rvf pypy && tar -jxf pypy-$VERSION-linux_x86_64-portable.tar.bz2
mv pypy-$VERSION-linux_x86_64-portable pypy
rm -vf pypy-$VERSION-linux_x86_64-portable.tar.bz2

ln -svf libbz2.so $PREFIX/lib/libbz2.so.1
ln -svf libncursesw.so $PREFIX/lib/libncurses.so.6

ln -svf ../lib/pypy/bin/pypy $PREFIX/bin/pypy
