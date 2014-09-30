VERSION=${VERSION-1.6.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://nginx.org/download/nginx-$VERSION.tar.gz"
rm -rf nginx-$VERSION && tar -zxf "nginx-$VERSION.tar.gz"
rm -f "nginx-$VERSION.tar.gz"
cd nginx-$VERSION

./configure --prefix=$PREFIX

make && make install
