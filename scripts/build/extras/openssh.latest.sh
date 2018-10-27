VERSION=${VERSION-7.9}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://cdn.openbsd.org/pub/OpenBSD/OpenSSH/openssh-$VERSION.tar.gz"
rm -rf ssh && tar -zxf "openssh-$VERSION.tar.gz"
rm -f "openssh-$VERSION.tar.gz"
cd ssh

install -v -m700 -d /var/lib/sshd
chown -v root:sys /var/lib/sshd

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --sysconfdir=/etc/ssh\
    --with-md5-passwords\
    --with-privsep-path=/var/lib/sshd

if [ "$SCUDUM_CROSS" == "1" ]; then
    make && make STRIP_OPT="" install-nokeys
else
    make && make install
fi

install -v -m755 contrib/ssh-copy-id /usr/bin
install -v -m644 contrib/ssh-copy-id.1 /usr/share/man/man1
install -v -m755 -d /usr/share/doc/openssh-$VERSION
install -v -m644 INSTALL LICENCE OVERVIEW README* /usr/share/doc/openssh-$VERSION
