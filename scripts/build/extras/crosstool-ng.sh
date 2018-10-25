VERSION=${VERSION-1.23.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "gperf" "which" "help2man" "unzip"

if [ "$VERSION" == "latest" ]; then
    rm -rf crosstool-ng && git clone --depth 1 "https://github.com/crosstool-ng/crosstool-ng.git"
    cd crosstool-ng
    ./bootstrap
else
    wget "http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-$VERSION.tar.bz2"
    rm -rf crosstool-ng-$VERSION && tar -jxf "crosstool-ng-$VERSION.tar.bz2"
    rm -f "crosstool-ng-$VERSION.tar.bz2"
    cd crosstool-ng-$VERSION
fi

./configure --prefix=$PREFIX
make && make install
