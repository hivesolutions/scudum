VERSION=${VERSION-3.5.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "xorg-applications" "pango"

wget "http://openbox.org/dist/openbox/openbox-$VERSION.tar.gz"
rm -rf openbox-$VERSION && tar -zxf "openbox-$VERSION.tar.gz"
rm -f "openbox-$VERSION.tar.gz"
cd openbox-$VERSION

./configure --prefix=$PREFIX
make && make install
