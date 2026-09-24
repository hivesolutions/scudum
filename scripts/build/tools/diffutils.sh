VERSION=${VERSION-3.12}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "https://mirrors.hive.pt/mirrors/scudum/diffutils/$VERSION/diffutils-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/diffutils/diffutils-$VERSION.tar.xz"
rm -rf diffutils-$VERSION && tar -Jxf "diffutils-$VERSION.tar.xz"
rm -f "diffutils-$VERSION.tar.xz"
cd diffutils-$VERSION

./configure\
    --prefix=/usr\
    --host=$SCUDUM_TARGET\
    --build=$(./build-aux/config.guess)\
    gl_cv_func_strcasecmp_works=yes

make && make DESTDIR=$SCUDUM install
