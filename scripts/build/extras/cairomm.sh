VERSION=${VERSION-1.10.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "cairo" "libsigc++"

wget "http://cairographics.org/releases/cairomm-$VERSION.tar.gz"
rm -rf cairomm-$VERSION && tar -xxf "cairomm-$VERSION.tar.gz"
rm -f "cairomm-$VERSION.tar.gz"
cd cairomm-$VERSION

./configure --prefix=$PREFIX
make && make install
