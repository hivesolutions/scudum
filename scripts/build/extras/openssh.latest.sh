VERSION=${VERSION-8.3p1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget --content-disposition "http://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-$VERSION.tar.gz"
rm -rf openssh-$VERSION && tar -zxf "openssh-$VERSION.tar.gz"
rm -f "openssh-$VERSION.tar.gz"
cd openssh-$VERSION

install -v -m700 -d /var/lib/sshd
chown -v root:sys /var/lib/sshd

./configure\
    --host=$ARCH_TARGET\
    --prefix=$PREFIX\
    --sysconfdir=/etc/ssh\
    --with-md5-passwords\
    --with-privsep-path=/var/lib/sshd

if [ "$SCUDUM_CROSS" == "1" ]; then
    make && make STRIP_OPT="" install-nokeys
else
    make && make install
fi

install -v -m755 contrib/ssh-copy-id $PREFIX/bin
install -v -m644 contrib/ssh-copy-id.1 $PREFIX/share/man/man1
install -v -m755 -d $PREFIX/share/doc/openssh-$VERSION
install -v -m644 INSTALL LICENCE OVERVIEW README* $PREFIX/share/doc/openssh-$VERSION
