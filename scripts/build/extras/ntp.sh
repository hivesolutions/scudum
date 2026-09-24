VERSION=${VERSION-4.2.8p18}
VERSION_M=${VERSION_M-4.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

if [ -z "$CFLAGS" ]; then export CFLAGS="-O2"; fi
export CFLAGS="$CFLAGS -fpic"

rget "https://mirrors.hive.pt/mirrors/scudum/ntp/$VERSION/ntp-$VERSION.tar.gz"\
    "https://downloads.nwtime.org/ntp/${VERSION%%p*}/ntp-$VERSION.tar.gz"\
    "https://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-$VERSION_M/ntp-$VERSION.tar.gz"\
    "https://ftp.osuosl.org/pub/blfs/conglomeration/ntp/ntp-$VERSION.tar.gz"
rm -rf ntp-$VERSION && tar -zxf "ntp-$VERSION.tar.gz"
rm -f "ntp-$VERSION.tar.gz"
cd ntp-$VERSION

# fixes the configure checks that fail with modern glibc and gcc versions
sed -i 's/getclock/getclock memchr/' sntp/m4/ntp_libntp.m4
sed -i 's/pthread_detach(NULL)/pthread_detach(0)/' sntp/m4/openldap-thread-check.m4
autoreconf -fiv

./configure --host=$ARCH_TARGET --prefix=$PREFIX --with-yielding-select=yes
make && make install
