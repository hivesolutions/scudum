VERSION=${VERSION-2.0.28}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget --content-disposition "http://downloads.sourceforge.net/acpid2/acpid-$VERSION.tar.xz?use_mirror=ayera"
rm -rf acpid-$VERSION && tar -Jxf "acpid-$VERSION.tar.xz"
rm -f "acpid-$VERSION.tar.xz"
cd acpid-$VERSION

./configure --prefix=$PREFIX
make && make install
