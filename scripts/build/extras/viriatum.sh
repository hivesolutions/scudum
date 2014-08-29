DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

rm -rf viriatum && git clone https://github.com/hivesolutions/viriatum.git
cd viriatum

./autogen.sh && ./configure --prefix=$PREFIX
make && make install
