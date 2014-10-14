VERSION=${VERSION-1.0.28}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://alsa.cybermirror.org/lib/alsa-lib-$VERSION.tar.bz2"
rm -rf alsa-lib-$VERSION && tar -jxf "alsa-lib-$VERSION.tar.bz2"
rm -f "alsa-lib-$VERSION.tar.bz2"
cd alsa-lib-$VERSION

./configure --prefix=$PREFIX
make && make install
