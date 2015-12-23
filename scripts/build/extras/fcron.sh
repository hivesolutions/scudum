VERSION=${VERSION-3.2.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://fcron.free.fr/archives/fcron-$VERSION.src.tar.gz"
rm -rf fcron-$VERSION && tar -jxf "fcron-$VERSION.src.tar.gz"
rm -f "fcron-$VERSION.src.tar.gz"
cd fcron-$VERSION

./configure\
    --prefix=$PREFIX\
    --without-sendmail\
    --with-boot-install=no\
    --with-systemdsystemunitdir=no

make && make install
