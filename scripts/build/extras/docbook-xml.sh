VERSION=${VERSION-4.5}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

depends "unzip"

wget "http://www.docbook.org/xml/$VERSION/docbook-xml-$VERSION.zip"
rm -rf docbook-xml-$VERSION && unzip "docbook-xml-$VERSION.zip" -d docbook-xml-$VERSION
rm -f "docbook-xml-$VERSION.zip"
cd docbook-xml-$VERSION

install -v -d -m755 $PREFIX/share/xml/docbook/xml-dtd-4.5
install -v -d -m755 /etc/xml
chown -R root:root .
cp -v -af docbook.cat *.dtd ent/ *.mod\
    $PREFIX/share/xml/docbook/xml-dtd-4.5

if [ ! -e /etc/xml/docbook ]; then
    xmlcatalog --noout --create /etc/xml/docbook
fi

xmlcatalog --noout --add "public"\
    "-//OASIS//DTD DocBook XML V4.5//EN"\
    "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"\
    /etc/xml/docbook
xmlcatalog --noout --add "public"\
    "-//OASIS//DTD DocBook XML CALS Table Model V4.5//EN"\
    "file://$PREFIX/share/xml/docbook/xml-dtd-4.5/calstblx.dtd"\
    /etc/xml/docbook
xmlcatalog --noout --add "public"\
    "-//OASIS//DTD XML Exchange Table Model 19990315//EN"\
    "file://$PREFIX/share/xml/docbook/xml-dtd-4.5/soextblx.dtd"\
    /etc/xml/docbook
xmlcatalog --noout --add "public"\
    "-//OASIS//ELEMENTS DocBook XML Information Pool V4.5//EN"\
    "file://$PREFIX/share/xml/docbook/xml-dtd-4.5/dbpoolx.mod"\
    /etc/xml/docbook
xmlcatalog --noout --add "public"\
    "-//OASIS//ELEMENTS DocBook XML Document Hierarchy V4.5//EN"\
    "file://$PREFIX/share/xml/docbook/xml-dtd-4.5/dbhierx.mod"\
    /etc/xml/docbook
xmlcatalog --noout --add "public"\
    "-//OASIS//ELEMENTS DocBook XML HTML Tables V4.5//EN"\
    "file://$PREFIX/share/xml/docbook/xml-dtd-4.5/htmltblx.mod"\
    /etc/xml/docbook
xmlcatalog --noout --add "public"\
    "-//OASIS//ENTITIES DocBook XML Notations V4.5//EN"\
    "file://$PREFIX/share/xml/docbook/xml-dtd-4.5/dbnotnx.mod"\
    /etc/xml/docbook
xmlcatalog --noout --add "public"\
    "-//OASIS//ENTITIES DocBook XML Character Entities V4.5//EN"\
    "file://$PREFIX/share/xml/docbook/xml-dtd-4.5/dbcentx.mod"\
    /etc/xml/docbook
xmlcatalog --noout --add "public"\
    "-//OASIS//ENTITIES DocBook XML Additional General Entities V4.5//EN"\
    "file://$PREFIX/share/xml/docbook/xml-dtd-4.5/dbgenent.mod"\
    /etc/xml/docbook
xmlcatalog --noout --add "rewriteSystem"\
    "http://www.oasis-open.org/docbook/xml/4.5"\
    "file://$PREFIX/share/xml/docbook/xml-dtd-4.5"\
    /etc/xml/docbook
xmlcatalog --noout --add "rewriteURI"\
    "http://www.oasis-open.org/docbook/xml/4.5"\
    "file://$PREFIX/share/xml/docbook/xml-dtd-4.5"\
    /etc/xml/docbook

for DTDVERSION in 4.1.2 4.2 4.3 4.4; do
    xmlcatalog --noout --add "public"\
        "-//OASIS//DTD DocBook XML V$DTDVERSION//EN"\
        "http://www.oasis-open.org/docbook/xml/$DTDVERSION/docbookx.dtd"\
        /etc/xml/docbook
    xmlcatalog --noout --add "rewriteSystem"\
        "http://www.oasis-open.org/docbook/xml/$DTDVERSION"\
        "file://$PREFIX/share/xml/docbook/xml-dtd-4.5"\
        /etc/xml/docbook
    xmlcatalog --noout --add "rewriteURI"\
        "http://www.oasis-open.org/docbook/xml/$DTDVERSION"\
        "file://$PREFIX/share/xml/docbook/xml-dtd-4.5"\
        /etc/xml/docbook
    xmlcatalog --noout --add "delegateSystem"\
        "http://www.oasis-open.org/docbook/xml/$DTDVERSION/"\
        "file:///etc/xml/docbook"\
        /etc/xml/catalog
    xmlcatalog --noout --add "delegateURI"\
        "http://www.oasis-open.org/docbook/xml/$DTDVERSION/"\
        "file:///etc/xml/docbook"\
        /etc/xml/catalog
done
