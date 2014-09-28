VERSION=${VERSION-4.5}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "unzip sgml-common"

wget "http://www.docbook.org/sgml/$VERSION/docbook-$VERSION.zip"
rm -rf docbook-$VERSION && unzip "docbook-$VERSION.zip" -d docbook-$VERSION
rm -f "docbook-$VERSION.zip"
cd docbook-$VERSION

sed -i -e '/ISO 8879/d' -e '/gml/d' docbook.cat

install -v -d $PREFIX/share/sgml/docbook/sgml-dtd-$VERSION
chown -R root:root .

install -v docbook.cat $PREFIX/share/sgml/docbook/sgml-dtd-$VERSION/catalog
cp -v -af *.dtd *.mod *.dcl $PREFIX/share/sgml/docbook/sgml-dtd-$VERSION

install-catalog --add /etc/sgml/sgml-docbook-dtd-$VERSION.cat\
    $PREFIX/share/sgml/docbook/sgml-dtd-$VERSION/catalog

install-catalog --add /etc/sgml/sgml-docbook-dtd-$VERSION.cat\
    /etc/sgml/sgml-docbook.cat
