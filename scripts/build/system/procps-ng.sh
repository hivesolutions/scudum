VERSION=${VERSION-4.0.7}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

export ac_cv_func_malloc_0_nonnull=yes
export ac_cv_func_realloc_0_nonnull=yes

rgeti "https://mirrors.hive.pt/mirrors/scudum/procps-ng/$VERSION/procps-ng-$VERSION.tar.xz"\
    "https://sourceforge.net/projects/procps-ng/files/Production/procps-ng-$VERSION.tar.xz"\
    "--output-document=procps-ng-$VERSION.tar.xz"
rm -rf procps-ng-$VERSION && tar -Jxf "procps-ng-$VERSION.tar.xz"
rm -f "procps-ng-$VERSION.tar.xz"
cd procps-ng-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --docdir=/usr/share/doc/procps-ng-$VERSION\
    --disable-static\
    --disable-skill\
    --disable-kill\
    --enable-watch8bit

make
test $TEST && make check
make install
