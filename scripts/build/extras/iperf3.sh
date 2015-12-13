VERSION=${VERSION-3.1.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "unzip"

wget "https://github.com/esnet/iperf/archive/$VERSION.zip" -O "iperf-$VERSION.zip"
rm -rf iperf-$VERSION && unzip "iperf-$VERSION.zip"
rm -f "iperf-$VERSION.zip"
cd iperf-$VERSION

./configure --prefix=$PREFIX
make && make install
