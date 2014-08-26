VERSION=${VERSION-1.9.1}

set -e

wget --no-check-certificate "http://ftp.gnu.org/gnu/inetutils/inetutils-$VERSION.tar.gz"
rm -rf inetutils-$VERSION && tar -zxf "inetutils-$VERSION.tar.gz"
rm -f "inetutils-$VERSION.tar.gz"
cd inetutils-$VERSION

sed -i -e '/gets is a/d' lib/stdio.in.h

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
