VERSION=${VERSION-5.9}

set -e +h

wget --no-check-certificate "ftp://ftp.gnu.org/gnu/ncurses/ncurses-$VERSION.tar.gz"
rm -rf ncurses-$VERSION && tar -zxf "ncurses-$VERSION.tar.gz"
rm -f "ncurses-$VERSION.tar.gz"
cd ncurses-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --mandir=/usr/share/man\
    --with-shared\
    --without-debug\
    --enable-pc-files\
    --enable-widec

make && make install

mv -v /usr/lib/libncursesw.so.5* /lib
ln -svf ../../lib/libncursesw.so.5 /usr/lib/libncursesw.so

for lib in ncurses form panel menu ; do
    rm -vf /usr/lib/lib${lib}.so
    echo "INPUT(-l${lib}w)" > /usr/lib/lib${lib}.so
    ln -svf lib${lib}w.a /usr/lib/lib${lib}.a
    ln -svf ${lib}w.pc /usr/lib/pkgconfig/${lib}.pc
done

rm -vf /usr/lib/libcursesw.so
echo "INPUT(-lncursesw)" > /usr/lib/libcursesw.so
ln -svf libncurses.so /usr/lib/libcurses.so
ln -svf libncursesw.a /usr/lib/libcursesw.a
ln -svf libncurses.a /usr/lib/libcurses.a

mkdir -pv /usr/share/doc/ncurses-$VERSION
cp -v -R doc/* /usr/share/doc/ncurses-$VERSION
