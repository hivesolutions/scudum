VERSION=${VERSION-704}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/less/$VERSION/less-$VERSION.tar.gz"\
    "https://www.greenwoodsoftware.com/less/less-$VERSION.tar.gz"
rm -rf less-$VERSION && tar -zxf "less-$VERSION.tar.gz"
rm -f "less-$VERSION.tar.gz"
cd less-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr --sysconfdir=/etc

make && make install
