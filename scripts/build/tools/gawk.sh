VERSION=${VERSION-5.4.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "https://mirrors.hive.pt/mirrors/scudum/gawk/$VERSION/gawk-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/gawk/gawk-$VERSION.tar.xz"
rget "https://mirrors.hive.pt/mirrors/scudum/gawk/$VERSION/gawk-$VERSION-upstream_fixes-1.patch"\
    "https://git.savannah.gnu.org/cgit/gawk.git/patch/awk.h?id=bf85f8a3175af703597082d4c7e0abc2066a44d3"\
    "--output-document=gawk-$VERSION-upstream_fixes-1.patch"
rm -rf gawk-$VERSION && tar -Jxf "gawk-$VERSION.tar.xz"
rm -f "gawk-$VERSION.tar.xz"
cd gawk-$VERSION

# fixes the node structure for builds without mpfr (as this one) where
# unassigned array elements do not compare equal to the empty string
patch -Np1 -i ../gawk-$VERSION-upstream_fixes-1.patch

sed -i 's/extras//' Makefile.in

./configure\
    --prefix=/usr\
    --host=$SCUDUM_TARGET\
    --build=$(build-aux/config.guess)

make && make DESTDIR=$SCUDUM install
