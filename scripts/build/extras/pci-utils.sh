VERSION=${VERSION-3.3.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "https://www.kernel.org/pub/software/utils/pciutils/pciutils-$VERSION.tar.xz"
rm -rf pciutils-$VERSION && tar -Jxf "pciutils-$VERSION.tar.xz"
rm -f "pciutils-$VERSION.tar.xz"
cd pciutils-$VERSION

PREFIX=$PREFIX SHARED=yes make
PREFIX=$PREFIX SHARED=yes make install
