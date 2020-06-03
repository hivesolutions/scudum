VERSION=${VERSION-1.4.14}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "c-ares"

wget --content-disposition "http://mosquitto.org/files/source/mosquitto-$VERSION.tar.gz"
rm -rf mosquitto-$VERSION && tar -zxf "mosquitto-$VERSION.tar.gz"
rm -f "mosquitto-$VERSION.tar.gz"
cd mosquitto-$VERSION

make && make install prefix=$PREFIX
