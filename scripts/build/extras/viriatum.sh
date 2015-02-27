DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "pcre"

rm -rf viriatum && git clone --depth 1 "https://github.com/hivesolutions/viriatum.git"
cd viriatum

./autogen.sh && ./configure --host=$ARCH_TARGET --prefix=$PREFIX --sysconfdir=/etc
make && make install
