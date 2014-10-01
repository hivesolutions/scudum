VERSION=${VERSION-2.09}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "jpeg"

wget "https://www.kraxel.org/releases/fbida/fbida-$VERSION.tar.gz"
rm -rf fbida-$VERSION && tar -zxf "fbida-$VERSION.tar.gz"
rm -f "fbida-$VERSION.tar.gz"
cd fbida-$VERSION

make
