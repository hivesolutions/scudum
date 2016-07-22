VERSION=${VERSION-1.13.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "python" "libxml2"

wget "https://github.com/nghttp2/nghttp2/releases/download/v$VERSION/nghttp2-$VERSION.tar.gz"
rm -rf nghttp2-$VERSION && tar -zxf "nghttp2-$VERSION.tar.gz"
rm -f "nghttp2-$VERSION.tar.gz"
cd nghttp2-$VERSION

./configure --prefix=$PREFIX --enable-app --enable-apps
make && make install
