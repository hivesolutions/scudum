DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rm -rf i7z && git clone --depth 1 "https://github.com/ajaiantilal/i7z.git"
cd i7z

make && prefix=$PREFIX make install
