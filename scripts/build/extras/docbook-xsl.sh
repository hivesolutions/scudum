VERSION=${VERSION-1.78.1}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

depends "unzip"

wget "http://downloads.sourceforge.net/docbook/docbook-xsl-$VERSION.tar.bz2"
rm -rf docbook-xsl-$VERSION && tar -jxf "docbook-xsl-$VERSION.tar.bz2"
rm -f "docbook-xsl-$VERSION.tar.bz2"
cd docbook-xsl-$VERSION

install -v -m755 -d $PREFIX/share/xml/docbook/xsl-stylesheets-$VERSION

cp -v -R VERSION common eclipse epub extensions fo highlighting html\
    htmlhelp images javahelp lib manpages params profiling\
    roundtrip slides template tests tools webhelp website\
    xhtml xhtml-1_1\
    $PREFIX/share/xml/docbook/xsl-stylesheets-$VERSION

ln -s VERSION $PREFIX/share/xml/docbook/xsl-stylesheets-$VERSION/VERSION.xsl

install -v -m644 -D README $PREFIX/share/doc/docbook-xsl-$VERSION/README.txt
install -v -m644 RELEASE-NOTES* NEWS* $PREFIX/share/doc/docbook-xsl-$VERSION
