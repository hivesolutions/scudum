VERSION=${VERSION-5.6.19}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

depends "cmake"

wget "http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-$VERSION.tar.gz"
rm -rf mysql-$VERSION && tar -zxf "mysql-$VERSION.tar.gz"
rm -f "mysql-$VERSION.tar.gz"
cd mysql-$VERSION

mkdir -pv build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_CXX_FLAGS="-w -fpermissive" -DCMAKE_C_FLAGS="-w -fpermissive"
make && make install

scripts/mysql_install_db
