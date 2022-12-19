VERSION=${VERSION-4.2.8p15}
VERSION_M=${VERSION_M-4.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "https://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-$VERSION_M/ntp-$VERSION.tar.gz"\
    "https://ftp.osuosl.org/pub/blfs/conglomeration/ntp/ntp-$VERSION.tar.gz"
rm -rf ntp-$VERSION && tar -zxf "ntp-$VERSION.tar.gz"
rm -f "ntp-$VERSION.tar.gz"
cd ntp-$VERSION

wget --content-disposition "http://archive.hive.pt/files/lfs/patches/ntp-$VERSION-glibc-1.patch"
patch -Np1 -i ntp-$VERSION-glibc-1.patch

./configure --host=$ARCH_TARGET --prefix=$PREFIX --with-yielding-select=yes
make && make install
