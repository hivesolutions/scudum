VERSION=${VERSION-7.0}
VERSION_L=${VERSION_L-70}
PATCH_SEQ=${PATCH_SEQ-1 3}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/readline/readline-$VERSION.tar.gz"
rm -rf readline-$VERSION && tar -zxf "readline-$VERSION.tar.gz"
rm -f "readline-$VERSION.tar.gz"
cd readline-$VERSION

for index in $(seq -f "%03g" $PATCH_SEQ); do
    wget --no-check-certificate http://ftp.gnu.org/gnu/readline/readline-$VERSION-patches/readline$VERSION_L-$index
    patch -Np0 -i readline$VERSION_L-$index
done

sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install
sed -i 's/as_fn_error ()/as_fn_error ()\n{\nreturn 0\n}\nold_as_fn_error ()\n/' configure

./configure --host=$ARCH_TARGET --prefix=/usr --libdir=/lib

make SHLIB_LIBS=-lncurses
make SHLIB_LIBS=-lncurses install

mv -v /lib/lib{readline,history}.a /usr/lib

rm -v /lib/lib{readline,history}.so
ln -svf ../../lib/libreadline.so.7 /usr/lib/libreadline.so
ln -svf ../../lib/libhistory.so.7 /usr/lib/libhistory.so

mkdir -pv /usr/share/doc/readline-$VERSION
install -v -m644 doc/*.{ps,pdf,html,dvi}\
    /usr/share/doc/readline-$VERSION
