VERSION="5.9"
tar -zxf "ncurses-$VERSION.tar.gz"
cd ncurses-$VERSION

./configure\
    --prefix=/usr\
    --mandir=/usr/share/man\
    --with-shared\
    --without-debug\
    --enable-pc-files\
    --enable-widec
make && make install

mv -v /usr/lib/libncursesw.so.5* /lib
ln -sfv ../../lib/libncursesw.so.5 /usr/lib/libncursesw.so

for lib in ncurses form panel menu ; do
    rm -vf /usr/lib/lib${lib}.so
    echo "INPUT(-l${lib}w)" > /usr/lib/lib${lib}.so
    ln -sfv lib${lib}w.a /usr/lib/lib${lib}.a
    ln -sfv ${lib}w.pc /usr/lib/pkgconfig/${lib}.pc
done

rm -vf /usr/lib/libcursesw.so
echo "INPUT(-lncursesw)" > /usr/lib/libcursesw.so
ln -sfv libncurses.so /usr/lib/libcurses.so
ln -sfv libncursesw.a /usr/lib/libcursesw.a
ln -sfv libncurses.a /usr/lib/libcurses.a

mkdir -v /usr/share/doc/ncurses-5.9
cp -v -R doc/* /usr/share/doc/ncurses-5.9

make distclean
./configure\
    --prefix=/usr\
    --with-shared\
    --without-normal\
    --without-debug\
    --without-cxx-binding
make sources libs
cp -av lib/lib*.so.5* /usr/lib

cd ..
rm -rf ncurses-$VERSION
