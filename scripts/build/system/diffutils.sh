VERSION=${VERSION-3.12}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/diffutils/$VERSION/diffutils-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/diffutils/diffutils-$VERSION.tar.xz"
rm -rf diffutils-$VERSION && tar -Jxf "diffutils-$VERSION.tar.xz"
rm -f "diffutils-$VERSION.tar.xz"
cd diffutils-$VERSION

if [ "$SCUDUM_CROSS" == "1" ]; then
    export gl_cv_func_strcasecmp_works=yes
    export ac_cv_path_PR_PROGRAM=/usr/bin/pr
fi

./configure --host=$ARCH_TARGET --prefix=/usr

make
test $TEST && make check
make install
