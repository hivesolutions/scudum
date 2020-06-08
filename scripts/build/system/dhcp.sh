VERSION=${VERSION-4.4.2}
VERSION_BIND=${VERSION_BIND-9.9.5-P1}

set -e +h

unset MAKEFLAGS

wget --no-check-certificate --content-disposition "ftp://ftp.isc.org/isc/dhcp/$VERSION/dhcp-$VERSION.tar.gz"
rm -rf dhcp-$VERSION && tar -zxf "dhcp-$VERSION.tar.gz"
rm -f "dhcp-$VERSION.tar.gz"
cd dhcp-$VERSION

if [ "$SCUDUM_CROSS" == "1" ]; then
    unset CFLAGS
    export BUILD_CC=gcc
fi

if [ -z "$CFLAGS" ]; then export CFLAGS="-O2"; fi
CFLAGS="$CFLAGS -D_PATH_DHCLIENT_SCRIPT='\"/sbin/dhclient-script\"'\
    -D_PATH_DHCPD_CONF='\"/etc/dhcp/dhcpd.conf\"'\
    -D_PATH_DHCLIENT_CONF='\"/etc/dhcp/dhclient.conf\"'" ./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --sysconfdir=/etc/dhcp\
    --localstatedir=/var\
    --with-randomdev=/dev/random\
    --with-srv-lease-file=/var/lib/dhcpd/dhcpd.leases\
    --with-srv6-lease-file=/var/lib/dhcpd/dhcpd6.leases\
    --with-cli-lease-file=/var/lib/dhclient/dhclient.leases\
    --with-cli6-lease-file=/var/lib/dhclient/dhclient6.leases

make && make install

mv -v /usr/sbin/dhclient /sbin &&
install -v -m755 client/scripts/linux /sbin/dhclient-script
