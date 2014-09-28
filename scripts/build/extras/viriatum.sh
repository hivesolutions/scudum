DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rm -rf viriatum && git clone --depth 1 https://github.com/hivesolutions/viriatum.git
cd viriatum

./autogen.sh && ./configure --prefix=$PREFIX
make && make install
