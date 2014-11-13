VERSION=${VERSION-1.9.2}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/inetutils/inetutils-$VERSION.tar.gz"
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
