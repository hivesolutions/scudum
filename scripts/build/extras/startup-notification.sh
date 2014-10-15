VERSION=${VERSION-0.12}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "xorg-libs" "xcb-util"

wget "http://www.freedesktop.org/software/startup-notification/releases/startup-notification-$VERSION.tar.gz"
rm -rf startup-notification-$VERSION && tar -zxf "startup-notification-$VERSION.tar.gz"
rm -f "startup-notification-$VERSION.tar.gz"
cd startup-notification-$VERSION

./configure --prefix=$PREFIX --disable-static
make && make install
