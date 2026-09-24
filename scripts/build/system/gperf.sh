VERSION=${VERSION-3.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/gperf/$VERSION/gperf-$VERSION.tar.gz"\
    "https://ftpmirror.gnu.org/gperf/gperf-$VERSION.tar.gz"
rm -rf gperf-$VERSION && tar -zxf "gperf-$VERSION.tar.gz"
rm -f "gperf-$VERSION.tar.gz"
cd gperf-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --docdir=/usr/share/doc/gperf-$VERSION

make && make install
