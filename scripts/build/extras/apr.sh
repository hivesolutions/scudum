VERSION=${VERSION-1.5.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://www.us.apache.org/dist/apr/apr-$VERSION.tar.gz"
rm -rf apr-$VERSION && tar -zxf "apr-$VERSION.tar.gz"
rm -f "apr-$VERSION.tar.gz"
cd apr-$VERSION

./configure --prefix=$PREFIX
make
chmod +x tools/gen_test_char
make install
