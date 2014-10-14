VERSION=${VERSION-8.6.9}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "python"

wget "http://downloads.sourceforge.net/asciidoc/asciidoc-$VERSION.tar.gz"
rm -rf asciidoc-$VERSION && tar -zxf "asciidoc-$VERSION.tar.gz"
rm -f "asciidoc-$VERSION.tar.gz"
cd asciidoc-$VERSION

./configure --prefix=$PREFIX
make && make install
