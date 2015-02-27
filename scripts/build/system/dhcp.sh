VERSION=${VERSION-4.3.1}
VERSION_BIND=${VERSION_BIND-9.9.5-P1}

set -e +h

wget --no-check-certificate "ftp://ftp.isc.org/isc/dhcp/$VERSION/dhcp-$VERSION.tar.gz"
rm -rf dhcp-$VERSION && tar -zxf "dhcp-$VERSION.tar.gz"
rm -f "dhcp-$VERSION.tar.gz"
cd dhcp-$VERSION

if [ "$SCUDUM_CROSS" == "1" ]; then
    export BUILD_CC=gcc

    cd bind
    tar -zxf bind-$VERSION_BIND
    cd bind-$VERSION_BIND
    wget --no-check-certificate "https://raw.githubusercontent.com/hivesolutions/patches/master/dhcp/bind-$VERSION_BIND-xcompile.patch"
    patch -Np0 -i bind-$VERSION_BIND-xcompile.patch
    sed -i 's/as_fn_error ()/as_fn_error ()\n{\nreturn 0\n}\nold_as_fn_error ()\n/' configure
    cd ../..

    wget --no-check-certificate "https://raw.githubusercontent.com/hivesolutions/patches/master/dhcp/dhcp-$VERSION-xcompile.patch"
    patch -Np0 -i dhcp-$VERSION-xcompile.patch
    sed -i 's/as_fn_error ()/as_fn_error ()\n{\nreturn 0\n}\nold_as_fn_error ()\n/' configure
fi

CFLAGS="-D_PATH_DHCLIENT_SCRIPT='\"/sbin/dhclient-script\"'\
    -D_PATH_DHCPD_CONF='\"/etc/dhcp/dhcpd.conf\"'\
    -D_PATH_DHCLIENT_CONF='\"/etc/dhcp/dhclient.conf\"' $CFLAGS" ./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --sysconfdir=/etc/dhcp\
    --localstatedir=/var\
    --with-srv-lease-file=/var/lib/dhcpd/dhcpd.leases\
    --with-srv6-lease-file=/var/lib/dhcpd/dhcpd6.leases\
    --with-cli-lease-file=/var/lib/dhclient/dhclient.leases\
    --with-cli6-lease-file=/var/lib/dhclient/dhclient6.leases

make && make install

mv -v /usr/sbin/dhclient /sbin &&
install -v -m755 client/scripts/linux /sbin/dhclient-script
