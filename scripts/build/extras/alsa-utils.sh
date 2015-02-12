VERSION=${VERSION-1.0.28}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://alsa.cybermirror.org/utils/alsa-utils-$VERSION.tar.bz2"
rm -rf alsa-utils-$VERSION && tar -jxf "alsa-utils-$VERSION.tar.bz2"
rm -f "alsa-utils-$VERSION.tar.bz2"
cd alsa-utils-$VERSION

./configure --prefix=$PREFIX
make && make install
