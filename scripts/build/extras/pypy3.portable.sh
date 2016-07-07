VERSION=${VERSION-5.2-alpha-20160602}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "expat" "libffi" "libtinfo"

wget "https://bitbucket.org/squeaky/portable-pypy/downloads/pypy3.3-$VERSION-linux_x86_64-portable.tar.bz2"
rm -rf pypy3.3-$VERSION-linux_x86_64-portable && tar -jxf "pypy3.3-$VERSION-linux_x86_64-portable.tar.bz2"

mv -v pypy3.3-$VERSION-linux_x86_64-portable.tar.bz2 $PREFIX/lib
cd $PREFIX/lib

rm -rvf pypy3.3 && tar -jxf pypy3.3-$VERSION-linux_x86_64-portable.tar.bz2
mv pypy3.3-$VERSION-linux_x86_64-portable pypy3.3
rm -vf pypy3.3-$VERSION-linux_x86_64-portable

ln -svf libbz2.so $PREFIX/lib/libbz2.so.1
ln -svf libncursesw.so $PREFIX/lib/libncurses.so.5

ln -svf ../lib/pypy3.3/bin/pypy3.3 $PREFIX/bin/pypy3
