DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "viriatum"

rm -rf mingus && git clone --depth 1 "https://github.com/joamag/mingus.git"
cd mingus

make && make install prefix=$PREFIX
