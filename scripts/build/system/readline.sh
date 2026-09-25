VERSION=${VERSION-8.3}
VERSION_L=${VERSION_L-83}
PATCH_SEQ=${PATCH_SEQ-1 6}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/readline/$VERSION/readline-$VERSION.tar.gz"\
    "https://ftpmirror.gnu.org/readline/readline-$VERSION.tar.gz"
rm -rf readline-$VERSION && tar -zxf "readline-$VERSION.tar.gz"
rm -f "readline-$VERSION.tar.gz"
cd readline-$VERSION

for index in $(seq -f "%03g" $PATCH_SEQ); do
    rgeti "https://mirrors.hive.pt/mirrors/scudum/readline/$VERSION/readline$VERSION_L-$index"\
        "https://ftpmirror.gnu.org/readline/readline-$VERSION-patches/readline$VERSION_L-$index"
    patch -Np0 -i readline$VERSION_L-$index
done

sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install
sed -i 's/-Wl,-rpath,[^ ]*//' support/shobj-conf

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --disable-static\
    --with-curses\
    --docdir=/usr/share/doc/readline-$VERSION

make SHLIB_LIBS="-lncursesw"
make SHLIB_LIBS="-lncursesw" install

mkdir -pv /usr/share/doc/readline-$VERSION
install -v -m644 doc/*.{ps,pdf,html,dvi} /usr/share/doc/readline-$VERSION
