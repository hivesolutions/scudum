VERSION=${VERSION-0.98}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "https://github.com/open-iscsi/open-isns/archive/v$VERSION.tar.gz"
rm -rf open-isns-$VERSION && tar -zxf "v$VERSION.tar.gz"
rm -f "v$VERSION.tar.gz"
cd open-isns-$VERSION

./configure --prefix=$PREFIX
make && make install && make install_hdrs && make install_lib
