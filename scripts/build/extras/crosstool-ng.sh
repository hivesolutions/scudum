VERSION=${VERSION-1.19.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "gperf"

wget "http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-$VERSION.tar.bz2"
rm -rf crosstool-ng-$VERSION && tar -jxf "crosstool-ng-$VERSION.tar.bz2"
rm -f "crosstool-ng-$VERSION.tar.bz2"
cd crosstool-ng-$VERSION

./configure --prefix=$PREFIX
make && make install
