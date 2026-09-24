VERSION=${VERSION-7.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

export ac_cv_func_malloc_0_nonnull=yes
export ac_cv_func_realloc_0_nonnull=yes

rget "https://mirrors.hive.pt/mirrors/scudum/cifs-utils/$VERSION/cifs-utils-$VERSION.tar.bz2"\
    "https://download.samba.org/pub/linux-cifs/cifs-utils/cifs-utils-$VERSION.tar.bz2"\
    "https://ftp.osuosl.org/pub/blfs/conglomeration/cifs-utils/cifs-utils-$VERSION.tar.bz2"
rm -rf cifs-utils-$VERSION && tar -jxf "cifs-utils-$VERSION.tar.bz2"
rm -f "cifs-utils-$VERSION.tar.bz2"
cd cifs-utils-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=$PREFIX\
    --disable-cifsupcall\
    --disable-cifscreds\
    --disable-cifsidmap\
    --disable-cifsacl\
    --disable-pam\
    --disable-systemd\
    --disable-smbinfo\
    --disable-pythontools\
    --disable-man
make && make install
