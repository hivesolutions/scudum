VERSION=${VERSION-0.0.28}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libxml2 libxslt docbook docbook-xml docbook-xsl"

wget --content-disposition "https://releases.pagure.org/xmlto/xmlto-$VERSION.tar.bz2"
rm -rf xmlto-$VERSION && tar -jxf "xmlto-$VERSION.tar.bz2"
rm -f "xmlto-$VERSION.tar.bz2"
cd xmlto-$VERSION

./configure --prefix=$PREFIX
make && make install
