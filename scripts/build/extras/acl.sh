VERSION=${VERSION-2.2.52}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://download.savannah.gnu.org/releases/acl/acl-$VERSION.src.tar.gz"
rm -rf acl-$VERSION && tar -zxf "acl-$VERSION.src.tar.gz"
rm -f "acl-$VERSION.src.tar.gz"
cd acl-$VERSION

./configure --prefix=$PREFIX
make && make install install-dev install-lib
