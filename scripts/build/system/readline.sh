VERSION=${VERSION-6.2}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/readline/readline-$VERSION.tar.gz"
rm -rf readline-$VERSION && tar -zxf "readline-$VERSION.tar.gz"
rm -f "readline-$VERSION.tar.gz"
cd readline-$VERSION

sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install

wget --no-check-certificate "http://www.linuxfromscratch.org/patches/lfs/7.3/readline-$VERSION-fixes-1.patch"
patch -Np1 -i readline-$VERSION-fixes-1.patch

./configure --prefix=/usr --libdir=/lib

make SHLIB_LIBS=-lncurses
make install

mv -v /lib/lib{readline,history}.a /usr/lib

rm -v /lib/lib{readline,history}.so
ln -sfv ../../lib/libreadline.so.6 /usr/lib/libreadline.so
ln -sfv ../../lib/libhistory.so.6 /usr/lib/libhistory.so

mkdir -v /usr/share/doc/readline-$VERSION
install -v -m644 doc/*.{ps,pdf,html,dvi}\
    /usr/share/doc/readline-$VERSION
