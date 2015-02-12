VERSION=${VERSION-2.0.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "dbus"

wget "http://www.cups.org/software/$VERSION/cups-$VERSION-source.tar.bz2"
rm -rf cups-$VERSION && tar -jxf "cups-$VERSION-source.tar.bz2"
rm -f "cups-$VERSION-source.tar.bz2"
cd cups-$VERSION

./configure --prefix=$PREFIX
make && make install
