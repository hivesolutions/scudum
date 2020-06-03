VERSION=${VERSION-0.10.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "http://downloads.sourceforge.net/check/check/$VERSION/check-$VERSION.tar.gz?use_mirror=ayera"\
    "https://ftp.osuosl.org/pub/blfs/conglomeration/check/check-$VERSION.tar.gz"
rm -rf check-$VERSION && tar -zxf "check-$VERSION.tar.gz"
rm -f "check-$VERSION.tar.gz"
cd check-$VERSION

PKG_CONFIG= ./configure --prefix=$PREFIX
make && make install
