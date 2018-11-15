VERSION=${VERSION-239}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "meson" "libcap"

wget "https://github.com/systemd/systemd/archive/v$VERSION.tar.gz"
rm -rf systemd-$VERSION && tar -zxf "v$VERSION.tar.gz"
rm -f "v$VERSION.tar.gz"
cd systemd-$VERSION

mkdir -p build && cd build
meson --prefix=$PREFIX --sysconfdir=/etc --localstatedir=/var -Dblkid=true ..
ninja && ninja install
