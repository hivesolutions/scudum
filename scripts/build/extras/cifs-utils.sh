VERSION=${VERSION-6.4}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

export ac_cv_func_malloc_0_nonnull=yes
export ac_cv_func_realloc_0_nonnull=yes

rget "http://ftp.samba.org/pub/linux-cifs/cifs-utils/cifs-utils-$VERSION.tar.bz2"\
    "http://ftp.osuosl.org/pub/blfs/conglomeration/cifs-utils/cifs-utils-$VERSION.tar.bz2"
rm -rf cifs-utils-$VERSION && tar -jxf "cifs-utils-$VERSION.tar.bz2"
rm -f "cifs-utils-$VERSION.tar.bz2"
cd cifs-utils-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX
make && make install
