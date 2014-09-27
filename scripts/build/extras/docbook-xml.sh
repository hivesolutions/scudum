VERSION=${VERSION-4.5}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

depends "unzip"

wget "http://www.docbook.org/xml/$VERSION/docbook-xml-$VERSION.zip"
rm -rf docbook-xml-$VERSION && unzip "docbook-xml-$VERSION.zip" -d docbook-xml-$VERSION
rm -f "docbook-xml-$VERSION.zip"
cd docbook-xml-$VERSION

install -v -d -m755 $PREFIX/share/xml/docbook/xml-dtd-$VERSION
install -v -d -m755 /etc/xml
chown -R root:root .
cp -v -af docbook.cat *.dtd ent/ *.mod\
    $PREFIX/share/xml/docbook/xml-dtd-$VERSION

if [ ! -e /etc/xml/docbook ]; then
    xmlcatalog --noout --create /etc/xml/docbook
fi

xmlcatalog --noout --add "public"\
    "-//OASIS//DTD DocBook XML V$VERSION//EN"\
    "http://www.oasis-open.org/docbook/xml/$VERSION/docbookx.dtd"\
    /etc/xml/docbook
xmlcatalog --noout --add "public"\
    "-//OASIS//DTD DocBook XML CALS Table Model V$VERSION//EN"\
    "file://$PREFIX/share/xml/docbook/xml-dtd-$VERSION/calstblx.dtd"\
    /etc/xml/docbook
xmlcatalog --noout --add "public"\
    "-//OASIS//DTD XML Exchange Table Model 19990315//EN"\
    "file://$PREFIX/share/xml/docbook/xml-dtd-$VERSION/soextblx.dtd"\
    /etc/xml/docbook
xmlcatalog --noout --add "public"\
    "-//OASIS//ELEMENTS DocBook XML Information Pool V$VERSION//EN"\
    "file://$PREFIX/share/xml/docbook/xml-dtd-$VERSION/dbpoolx.mod"\
    /etc/xml/docbook
xmlcatalog --noout --add "public"\
    "-//OASIS//ELEMENTS DocBook XML Document Hierarchy V$VERSION//EN"\
    "file://$PREFIX/share/xml/docbook/xml-dtd-$VERSION/dbhierx.mod"\
    /etc/xml/docbook
xmlcatalog --noout --add "public"\
    "-//OASIS//ELEMENTS DocBook XML HTML Tables V$VERSION//EN"\
    "file://$PREFIX/share/xml/docbook/xml-dtd-$VERSION/htmltblx.mod"\
    /etc/xml/docbook
xmlcatalog --noout --add "public"\
    "-//OASIS//ENTITIES DocBook XML Notations V$VERSION//EN"\
    "file://$PREFIX/share/xml/docbook/xml-dtd-$VERSION/dbnotnx.mod"\
    /etc/xml/docbook
xmlcatalog --noout --add "public"\
    "-//OASIS//ENTITIES DocBook XML Character Entities V$VERSION//EN"\
    "file://$PREFIX/share/xml/docbook/xml-dtd-$VERSION/dbcentx.mod"\
    /etc/xml/docbook
xmlcatalog --noout --add "public"\
    "-//OASIS//ENTITIES DocBook XML Additional General Entities V$VERSION//EN"\
    "file://$PREFIX/share/xml/docbook/xml-dtd-$VERSION/dbgenent.mod"\
    /etc/xml/docbook
xmlcatalog --noout --add "rewriteSystem"\
    "http://www.oasis-open.org/docbook/xml/$VERSION"\
    "file://$PREFIX/share/xml/docbook/xml-dtd-$VERSION"\
    /etc/xml/docbook
xmlcatalog --noout --add "rewriteURI"\
    "http://www.oasis-open.org/docbook/xml/$VERSION"\
    "file://$PREFIX/share/xml/docbook/xml-dtd-$VERSION"\
    /etc/xml/docbook

for DTDVERSION in 4.1.2 4.2 4.3 4.4; do
    xmlcatalog --noout --add "public"\
        "-//OASIS//DTD DocBook XML V$DTDVERSION//EN"\
        "http://www.oasis-open.org/docbook/xml/$DTDVERSION/docbookx.dtd"\
        /etc/xml/docbook
    xmlcatalog --noout --add "rewriteSystem"\
        "http://www.oasis-open.org/docbook/xml/$DTDVERSION"\
        "file://$PREFIX/share/xml/docbook/xml-dtd-$VERSION"\
        /etc/xml/docbook
    xmlcatalog --noout --add "rewriteURI"\
        "http://www.oasis-open.org/docbook/xml/$DTDVERSION"\
        "file://$PREFIX/share/xml/docbook/xml-dtd-$VERSION"\
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
