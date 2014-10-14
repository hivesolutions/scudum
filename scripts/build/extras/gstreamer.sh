VERSION=${VERSION-0.10.36}
VERSION_L=${VERSION_L-0.10}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "glib" "libxml2"

wget "http://ftp.gnome.org/pub/gnome/sources/gstreamer/$VERSION_L/gstreamer-$VERSION.tar.xz"
rm -rf gstreamer-$VERSION && tar -Jxf "gstreamer-$VERSION.tar.xz"
rm -f "gstreamer-$VERSION.tar.xz"
cd gstreamer-$VERSION

sed -i -e '/YYLEX_PARAM/d'\
    -e '/parse-param.*scanner/i %lex-param { void *scanner }'\
    gst/parse/grammar.y

./configure --prefix=$PREFIX --disable-static
make && make install
