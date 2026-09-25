VERSION=${VERSION-4.0.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/mpdecimal/$VERSION/mpdecimal-$VERSION.tar.gz"\
    "https://www.bytereef.org/software/mpdecimal/releases/mpdecimal-$VERSION.tar.gz"
rm -rf mpdecimal-$VERSION && tar -zxf "mpdecimal-$VERSION.tar.gz"
rm -f "mpdecimal-$VERSION.tar.gz"
cd mpdecimal-$VERSION

./configure\
    --prefix=/usr\
    --disable-static\
    --docdir=/usr/share/doc/mpdecimal-$VERSION

make && make install
