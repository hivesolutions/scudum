DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

export CFLAGS="$CFLAGS -I/usr/local/include/php -I/usr/local/include/php/main\
    -I/usr/local/include/php/TSRM -I/usr/local/include/php/Zend\
    -I/opt/include/php -I/opt/include/php/main -I/opt/include/php/TSRM\
    -I/opt/include/php/Zend"

rm -rf viriatum && git clone --depth 1 https://github.com/hivesolutions/viriatum.git
cd viriatum/modules/mod_php

./autogen.sh && ./configure --prefix=$PREFIX
make && make install
