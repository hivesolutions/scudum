VERSION=${VERSION-1.5.4}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "apr"

wget "http://archive.apache.org/dist/apr/apr-util-$VERSION.tar.gz"
rm -rf apr-util-$VERSION && tar -zxf "apr-util-$VERSION.tar.gz"
rm -f "apr-util-$VERSION.tar.gz"
cd apr-util-$VERSION

./configure --prefix=$PREFIX --with-apr=$PREFIX
make && make install
