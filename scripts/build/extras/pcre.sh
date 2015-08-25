VERSION=${VERSION-8.37}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-$VERSION.tar.gz"
rm -rf pcre-$VERSION && tar -zxf "pcre-$VERSION.tar.gz"
rm -f "pcre-$VERSION.tar.gz"
cd pcre-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX --enable-unicode-properties
make && make install
