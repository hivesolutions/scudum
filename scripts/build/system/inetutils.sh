VERSION=${VERSION-1.9.2}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/inetutils/inetutils-$VERSION.tar.gz"
rm -rf inetutils-$VERSION && tar -zxf "inetutils-$VERSION.tar.gz"
rm -f "inetutils-$VERSION.tar.gz"
cd inetutils-$VERSION

echo '#define PATH_PROCNET_DEV "/proc/net/dev"' >> ifconfig/system/linux.h

./configure\
    --prefix=/usr\
    --libexecdir=/usr/sbin\
    --localstatedir=/var\
    --disable-logger\
    --disable-syslogd\
    --disable-whois\
    --disable-servers

make
test $TEST && make check
make install
mv -v /usr/bin/{hostname,ping,ping6,traceroute} /bin
mv -v /usr/bin/ifconfig /sbin
