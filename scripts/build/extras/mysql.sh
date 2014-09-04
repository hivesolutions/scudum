VERSION=${VERSION-5.6.20}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

depends "cmake"

wget "http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-$VERSION.tar.gz"
rm -rf mysql-$VERSION && tar -zxf "mysql-$VERSION.tar.gz"
rm -f "mysql-$VERSION.tar.gz"
cd mysql-$VERSION

groupadd mysql
useradd -r -g mysql mysql

mkdir -pv build && cd build

cmake ..\
    -DCMAKE_INSTALL_PREFIX=$PREFIX/mysql\
    -DWITH_UNIT_TESTS=OFF\
    -DCMAKE_CXX_FLAGS="-w -fpermissive"\
    -DCMAKE_C_FLAGS="-w -fpermissive"

make && make install

ln -s ../mysql/bin/mysql $PREFIX/bin/mysql

cd $PREFIX/mysql

chown -R mysql:mysql .

scripts/mysql_install_db --user=mysql

chown -R root .
chown -R mysql data
