source /etc/scudum/KERNEL

VERSION=${VERSION-}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

#@todo we need to review all of these !!!!

wget "http://www.ijg.org/files/jpegsrc.v$VERSION.tar.gz"
rm -rf jpeg-$VERSION && tar -zxf "jpegsrc.v$VERSION.tar.gz"
rm -f "jpegsrc.v$VERSION.tar.gz"
cd jpeg-$VERSION

./configure --prefix=$PREFIX
make && make install