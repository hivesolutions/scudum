VERSION=${VERSION-2.26}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "https://git.kernel.org/pub/scm/libs/libcap/libcap.git/snapshot/libcap-$VERSION.tar.gz"
rm -rf libcap-$VERSION && tar -zxf "libcap-$VERSION.tar.gz"
rm -f "libcap-$VERSION.tar.gz"
cd libcap-$VERSION

make && make install
