VERSION=${VERSION-3.2.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://fcron.free.fr/archives/fcron-$VERSION.src.tar.gz"
rm -rf fcron-$VERSION && tar -zxf "fcron-$VERSION.src.tar.gz"
rm -f "fcron-$VERSION.src.tar.gz"
cd fcron-$VERSION

if [ "$SCUDUM_CROSS" == "1" ]; then
    ./configure\
        --host=$ARCH_TARGET\
        --prefix=$PREFIX\
        --sysconfdir=/etc\
        --localstatedir=/var\
        --without-sendmail\
        --with-editor=vi\
        --with-boot-install=no\
        --with-systemdsystemunitdir=no
else
    ./configure\
        --host=$ARCH_TARGET\
        --prefix=$PREFIX\
        --sysconfdir=/etc\
        --localstatedir=/var\
        --without-sendmail\
        --with-boot-install=no\
        --with-systemdsystemunitdir=no
fi

make && y | make install
