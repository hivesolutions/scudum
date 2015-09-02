VERSION=${VERSION-2.4.16}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "apr" "apr-util"

wget "http://archive.apache.org/dist/httpd/httpd-$VERSION.tar.gz"
rm -rf httpd-$VERSION && tar -zxf "httpd-$VERSION.tar.gz"
rm -f "httpd-$VERSION.tar.gz"
cd httpd-$VERSION

./configure --prefix=$PREFIX
make && make install
