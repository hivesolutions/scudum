VERSION=${VERSION-8.6.9}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

depends "python"

wget "http://prdownloads.sourceforge.net/asciidoc/asciidoc-$VERSION.tar.gz"
rm -rf asciidoc-$VERSION && tar -zxf "asciidoc-$VERSION.tar.gz"
rm -f "asciidoc-$VERSION.tar.gz"
cd asciidoc-$VERSION

./configure --prefix=$PREFIX
make && make install
