VERSION=${VERSION-6.6}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "https://mirrors.hive.pt/mirrors/scudum/ncurses/$VERSION/ncurses-$VERSION.tar.gz"\
    "https://invisible-mirror.net/archives/ncurses/ncurses-$VERSION.tar.gz"
rm -rf ncurses-$VERSION && tar -zxf "ncurses-$VERSION.tar.gz"
rm -f "ncurses-$VERSION.tar.gz"
cd ncurses-$VERSION

mkdir build
pushd build
    ../configure --prefix=$PREFIX AWK=gawk
    make -C include
    make -C progs tic
    install progs/tic $PREFIX/bin
popd

./configure\
    --prefix=/usr\
    --host=$SCUDUM_TARGET\
    --build=$(./config.guess)\
    --mandir=/usr/share/man\
    --with-manpage-format=normal\
    --with-shared\
    --without-normal\
    --with-cxx-shared\
    --without-debug\
    --without-ada\
    --disable-stripping\
    AWK=gawk

make && make DESTDIR=$SCUDUM install

ln -svf libncursesw.so $SCUDUM/usr/lib/libncurses.so
sed -e 's/^#if.*XOPEN.*$/#if 1/' -i $SCUDUM/usr/include/curses.h
