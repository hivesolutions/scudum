VERSION="6.2"
tar -zxf "readline-$VERSION.tar.gz"
cd readline-$VERSION

sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install

patch -Np1 -i ../readline-$VERSION-fixes-1.patch

./configure --prefix=/usr --libdir=/lib
make SHLIB_LIBS=-lncurses
make install

mv -v /lib/lib{readline,history}.a /usr/lib

rm -v /lib/lib{readline,history}.so
ln -sfv ../../lib/libreadline.so.6 /usr/lib/libreadline.so
ln -sfv ../../lib/libhistory.so.6 /usr/lib/libhistory.so

mkdir -v /usr/share/doc/readline-6.2
install -v -m644 doc/*.{ps,pdf,html,dvi}\
    /usr/share/doc/readline-6.2

cd ..
rm -rf readline-$VERSION
