VERSION=${VERSION-3-4-0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "which"

wget "https://github.com/lm-sensors/lm-sensors/archive/V$VERSION.tar.gz"
rm -rf lm-sensors-$VERSION && tar -zxf "V$VERSION.tar.gz"
rm -f "V$VERSION.tar.gz"
cd lm-sensors-$VERSION

make PREFIX=$PREFIX && make install PREFIX=$PREFIX
