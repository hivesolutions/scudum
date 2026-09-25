VERSION=${VERSION-6.6}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/ncurses/$VERSION/ncurses-$VERSION.tar.gz"\
    "https://invisible-mirror.net/archives/ncurses/ncurses-$VERSION.tar.gz"
rm -rf ncurses-$VERSION && tar -zxf "ncurses-$VERSION.tar.gz"
rm -f "ncurses-$VERSION.tar.gz"
cd ncurses-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --mandir=/usr/share/man\
    --with-shared\
    --without-termlib\
    --without-debug\
    --without-normal\
    --with-cxx-shared\
    --enable-pc-files\
    --enable-widec\
    --with-pkg-config-libdir=/usr/lib/pkgconfig

make && make DESTDIR=$PWD/dest install

sed -e 's/^#if.*XOPEN.*$/#if 1/' -i dest/usr/include/curses.h
cp --remove-destination -av dest/* /

for lib in ncurses form panel menu ; do
    ln -svf lib${lib}w.so /usr/lib/lib${lib}.so
    ln -svf ${lib}w.pc /usr/lib/pkgconfig/${lib}.pc
done

ln -svf libncursesw.so /usr/lib/libcurses.so
ln -svf libncursesw.so.6 /usr/lib/libtinfo.so.6
ln -svf libtinfo.so.6 /usr/lib/libtinfo.so

cp -v -R doc -T /usr/share/doc/ncurses-$VERSION
