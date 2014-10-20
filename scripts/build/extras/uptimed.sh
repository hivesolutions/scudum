VERSION=${VERSION-0.3.17}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://podgorny.cz/uptimed/releases/uptimed-$VERSION.tar.bz2"
rm -rf uptimed-$VERSION && tar -jxf "uptimed-$VERSION.tar.bz2"
rm -f "uptimed-$VERSION.tar.bz2"
cd uptimed-$VERSION

./configure --prefix=$PREFIX
make && make install
