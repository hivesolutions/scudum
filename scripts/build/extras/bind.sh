VERSION=${VERSION-9.14.12}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget --content-disposition "https://ftp.isc.org/isc/bind9/$VERSION/bind-$VERSION.tar.gz"
rm -rf bind-$VERSION && tar -zxf "bind-$VERSION.tar.gz"
rm -f "bind-$VERSION.tar.gz"
cd bind-$VERSION

if [ "$SCUDUM_CROSS" == "1" ]; then
    BUILD_CC=gcc ./configure\
        --host=$ARCH_TARGET\
        --prefix=$PREFIX\
        --sysconfdir=/etc/bind\
        --localstatedir=/var\
        --disable-linux-caps\
        --with-randomdev=no\
        --with-ecdsa=yes\
        --with-eddsa=yes\
        --with-gost=yes
    make && make install
else
    ./configure\
        --prefix=$PREFIX\
        --sysconfdir=/etc/bind\
        --localstatedir=/var\
        --disable-linux-caps
    make && make install
fi

mkdir -p /var/bind
