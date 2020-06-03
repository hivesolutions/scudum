VERSION=${VERSION-4.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget --content-disposition "http://downloads.sourceforge.net/squashfs/squashfs$VERSION.tar.gz?use_mirror=astuteinternet"
rm -rf squashfs$VERSION && tar -zxf "squashfs$VERSION.tar.gz"
rm -f "squashfs$VERSION.tar.gz"
cd squashfs$VERSION/squashfs-tools

make XZ_SUPPORT=1 && make INSTALL_DIR=$PREFIX/bin install
