VERSION=${VERSION-3.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "lvm2"

wget --no-check-certificate "http://ftp.gnu.org/gnu/parted/parted-$VERSION.tar.xz"
rm -rf parted-$VERSION && tar -Jxf "parted-$VERSION.tar.xz"
rm -f "parted-$VERSION.tar.xz"
cd parted-$VERSION

./configure --prefix=$PREFIX
make && make install
