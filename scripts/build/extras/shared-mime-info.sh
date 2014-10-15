VERSION=${VERSION-1.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "glib" "libxml2"

unset MAKEFLAGS

wget "http://freedesktop.org/~hadess/shared-mime-info-$VERSION.tar.xz"
rm -rf shared-mime-info-$VERSION && tar -Jxf "shared-mime-info-$VERSION.tar.xz"
rm -f "shared-mime-info-$VERSION.tar.xz"
cd shared-mime-info-$VERSION

./configure --prefix=$PREFIX
make && make install
