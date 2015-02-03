VERSION=${VERSION-1.0.8}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libev"

rm -rf weighttp && git clone --depth 1 git://git.lighttpd.net/weighttp
cd weighttp

./waf configure
./waf build && ./waf install
