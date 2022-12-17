VERSION=${VERSION-9.5.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "mesa" "glew" "glut"

wget --content-disposition "ftp://ftp.freedesktop.org/pub/mesa/demos/$VERSION/mesa-demos-$VERSION.tar.gz"
rm -rf mesa-demos-$VERSION && tar -zxf "mesa-demos-$VERSION.tar.gz"
rm -f "mesa-demos-$VERSION.tar.gz"
cd mesa-demos-$VERSION

./configure --prefix=$PREFIX
make && make install
