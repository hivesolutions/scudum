VERSION=${VERSION-5.6.20}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget "http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-$VERSION.tar.gz"
rm -rf mysql-$VERSION && tar -zxf "mysql-$VERSION.tar.gz"
rm -f "mysql-$VERSION.tar.gz"
cd mysql-$VERSION

./configure --prefix=$PREFIX
make && make install
