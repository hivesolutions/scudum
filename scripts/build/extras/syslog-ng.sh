VERSION=${VERSION-3.18.1}
VERSION_JSON_C=${VERSION_JSON_C-0.13.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "json-c"

wget --content-disposition "https://github.com/balabit/syslog-ng/releases/download/syslog-ng-$VERSION/syslog-ng-$VERSION.tar.gz"
rm -rf syslog-ng-$VERSION && tar -zxf "syslog-ng-$VERSION.tar.gz"
rm -f "syslog-ng-$VERSION.tar.gz"
cd syslog-ng-$VERSION

wget --content-disposition "https://s3.amazonaws.com/json-c_releases/releases/json-c-$VERSION_JSON_C.tar.gz"
tar -zxf "json-c-$VERSION_JSON_C.tar.gz"
mv json-c-$VERSION_JSON_C lib/jsonc

./configure --host=$ARCH_TARGET --prefix=$PREFIX
make && make install
