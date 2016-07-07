VERSION=${VERSION-5.9}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

wget --no-check-certificate "ftp://ftp.gnu.org/gnu/ncurses/ncurses-$VERSION.tar.gz"
rm -rf ncurses-$VERSION && tar -zxf "ncurses-$VERSION.tar.gz"
rm -f "ncurses-$VERSION.tar.gz"
cd ncurses-$VERSION

wget "http://archive.hive.pt/files/lfs/patches/ncurses-$VERSION-gcc_5-1.patch"
patch -Np1 -i ncurses-$VERSION-gcc_5-1.patch

./configure\
    --prefix=$PREFIX\
    --mandir=$PREFIX/share/man\
    --with-shared\
    --with-termlib\
    --without-debug\
    --enable-pc-files

make

cp -av lib/libtinfo* $PREFIX/lib
