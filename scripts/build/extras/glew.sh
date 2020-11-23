VERSION=${VERSION-1.12.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "x11" "mesa" "glu"

wget --content-disposition "http://downloads.sourceforge.net/glew/glew/glew-$VERSION.tgz?use_mirror=netix" "--output-document=glew-$VERSION.tgz"
rm -rf glew-$VERSION && tar -zxf "glew-$VERSION.tgz"
rm -f "glew-$VERSION.tar.xz"
cd glew-$VERSION

make GLEW_PREFIX=$PREFIX GLEW_DEST=$PREFIX
make GLEW_PREFIX=$PREFIX GLEW_DEST=$PREFIX install
