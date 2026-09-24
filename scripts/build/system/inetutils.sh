VERSION=${VERSION-2.8}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/inetutils/$VERSION/inetutils-$VERSION.tar.gz"\
    "https://ftpmirror.gnu.org/inetutils/inetutils-$VERSION.tar.gz"
rm -rf inetutils-$VERSION && tar -zxf "inetutils-$VERSION.tar.gz"
rm -f "inetutils-$VERSION.tar.gz"
cd inetutils-$VERSION

sed -i 's/def HAVE_TERMCAP_TGETENT/ 1/' telnet/telnet.c

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --bindir=/usr/bin\
    --localstatedir=/var\
    --disable-logger\
    --disable-whois\
    --disable-rcp\
    --disable-rexec\
    --disable-rlogin\
    --disable-rsh\
    --disable-servers

make
test $TEST && make check
make install

mv -v /usr/{,s}bin/ifconfig
