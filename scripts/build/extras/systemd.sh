VERSION=${VERSION-latest}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "meson" "libcap"

if [ "$VERSION" == "latest" ]; then
    rm -rf systemd && git clone --depth 1 "https://github.com/systemd/systemd.git"
    cd systemd
else
    wget --content-disposition "https://github.com/systemd/systemd/archive/v$VERSION.tar.gz"
    rm -rf systemd-$VERSION && tar -zxf "v$VERSION.tar.gz"
    rm -f "v$VERSION.tar.gz"
    cd systemd-$VERSION
fi

mkdir -p build && cd build
meson --prefix=$PREFIX ..
ninja && ninja install
