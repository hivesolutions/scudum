VERSION=${VERSION-1.9.4}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget --content-disposition "http://ftp.gnu.org/gnu/inetutils/inetutils-$VERSION.tar.gz"
rm -rf inetutils-$VERSION && tar -zxf "inetutils-$VERSION.tar.gz"
rm -f "inetutils-$VERSION.tar.gz"
cd inetutils-$VERSION

echo "#define PATH_PROCNET_DEV \"/proc/net/dev\"" >> ifconfig/system/linux.h

./configure\
    --prefix=$PREFIX\
    --libexecdir=$PREFIX/sbin\
    --localstatedir=/var\
    --disable-logger\
    --disable-syslogd\
    --disable-whois\
    --disable-servers

make && make install
