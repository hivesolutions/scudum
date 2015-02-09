VERSION=${VERSION-1.12.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "x11" "mesa"

wget "http://downloads.sourceforge.net/glew/glew/glew-$VERSION.tgz"
rm -rf glew-$VERSION && tar -zxf "glew-$VERSION.tgz"
rm -f "glew-$VERSION.tar.xz"
cd glew-$VERSION

GLEW_DEST=$PREFIX make && GLEW_DEST=$PREFIX make install
