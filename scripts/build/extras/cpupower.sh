VERSION=${VERSION-5.17.4}
VERSION_L=${VERSION_L-5.x}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "pci-utils"

wget --content-disposition "https://www.kernel.org/pub/linux/kernel/v$VERSION_L/linux-$VERSION.tar.xz"
rm -rf linux-$VERSION && tar -Jxf "linux-$VERSION.tar.xz"
rm -f "linux-$VERSION.tar.xz"
cd linux-$VERSION/tools/power/cpupower

make && make DESTDIR=$PRFEFIX install
