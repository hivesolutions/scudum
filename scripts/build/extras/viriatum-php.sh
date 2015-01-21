DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "viriatum" "php"

export CFLAGS="$CFLAGS -I/usr/include/php -I/usr/include/php/main\
    -I/usr/include/php/TSRM -I/usr/include/php/Zend -I$PREFIX/include/php\
    -I$PREFIX/include/php/main -I$PREFIX/include/php/TSRM -I$PREFIX/include/php/Zend"

rm -rf viriatum && git clone --depth 1 https://github.com/hivesolutions/viriatum.git
cd viriatum/modules/mod_php

./autogen.sh && ./configure --prefix=$PREFIX
make && make install
