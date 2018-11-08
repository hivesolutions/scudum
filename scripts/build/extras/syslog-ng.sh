VERSION=${VERSION-3.18.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "https://github.com/balabit/syslog-ng/releases/download/syslog-ng-$VERSION/syslog-ng-$VERSION.tar.gz"
rm -rf syslog-ng-$VERSION && tar -zxf "syslog-ng-$VERSION.tar.gz"
rm -f "syslog-ng-$VERSION.tar.gz"
cd syslog-ng-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX
make && make install
