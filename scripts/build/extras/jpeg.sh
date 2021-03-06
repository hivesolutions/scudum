VERSION=${VERSION-9a}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget --content-disposition "http://www.ijg.org/files/jpegsrc.v$VERSION.tar.gz"
rm -rf jpeg-$VERSION && tar -zxf "jpegsrc.v$VERSION.tar.gz"
rm -f "jpegsrc.v$VERSION.tar.gz"
cd jpeg-$VERSION

./configure --prefix=$PREFIX
make && make install
