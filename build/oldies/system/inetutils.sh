VERSION="1.9.1"
tar -zxf "inetutils-$VERSION.tar.gz"
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
make check
make install
mv -v /usr/bin/{hostname,ping,ping6,traceroute} /bin

cd ..
rm -rf inetutils-$VERSION
