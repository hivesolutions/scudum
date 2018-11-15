VERSION=${VERSION-2.0.875}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "open-isns"

wget "https://github.com/open-iscsi/open-iscsi/archive/$VERSION.tar.gz"
rm -rf open-iscsi-$VERSION && tar -zxf "$VERSION.tar.gz"
rm -f "$VERSION.tar.gz"
cd open-iscsi-$VERSION

make && make install
