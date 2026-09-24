VERSION=${VERSION-23.7}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

export ac_cv_func_malloc_0_nonnull=yes
export ac_cv_func_realloc_0_nonnull=yes

rgeti "https://mirrors.hive.pt/mirrors/scudum/psmisc/$VERSION/psmisc-$VERSION.tar.xz"\
    "https://sourceforge.net/projects/psmisc/files/psmisc/psmisc-$VERSION.tar.xz"\
    "--output-document=psmisc-$VERSION.tar.xz"
rm -rf psmisc-$VERSION && tar -Jxf "psmisc-$VERSION.tar.xz"
rm -f "psmisc-$VERSION.tar.xz"
cd psmisc-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr

make && make install
