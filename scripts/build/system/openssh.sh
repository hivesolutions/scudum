VERSION=${VERSION-6.7p1}

set -e +h

wget --no-check-certificate "http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-$VERSION.tar.gz"
rm -rf openssh-$VERSION && tar -zxf "openssh-$VERSION.tar.gz"
rm -f "openssh-$VERSION.tar.gz"
cd openssh-$VERSION

install -v -m700 -d /var/lib/sshd
chown -v root:sys /var/lib/sshd

if [ "$SCUDUM_CROSS" == "0" ]; then
    groupadd -g 50 sshd
    useradd -c "sshd PrivSep" -d /var/lib/sshd -g sshd -s /bin/false -u 50 sshd
fi

if [ "$SCUDUM_CROSS" == "1" ]; then
    export LD=$CC
fi

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --sysconfdir=/etc/ssh\
    --with-md5-passwords\
    --with-privsep-path=/var/lib/sshd

make && make install

install -v -m755 contrib/ssh-copy-id /usr/bin
install -v -m644 contrib/ssh-copy-id.1 /usr/share/man/man1
install -v -m755 -d /usr/share/doc/openssh-$VERSION
install -v -m644 INSTALL LICENCE OVERVIEW README* /usr/share/doc/openssh-$VERSION
