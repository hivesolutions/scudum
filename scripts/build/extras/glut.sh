VERSION=${VERSION-7.9.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "mesa"

wget "ftp://ftp.freedesktop.org/pub/mesa/glut/MesaGLUT-$VERSION.tar.gz"
rm -rf MesaGLUT-$VERSION && tar -zxf "MesaGLUT-$VERSION.tar.gz"
rm -f "MesaGLUT-$VERSION.tar.gz"
cd MesaGLUT-$VERSION

./configure --prefix=$PREFIX
make && make install
