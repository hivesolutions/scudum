VERSION=${VERSION-0.40}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "https://www.kernel.org/pub/software/network/tftp/tftp-hpa-$VERSION.tar.gz"
rm -rf tftp-hpa-$VERSION && tar -zxf "tftp-hpa-$VERSION.tar.gz"
rm -f "tftp-hpa-$VERSION.tar.gz"
cd tftp-hpa-$VERSION

./configure --prefix=$PREFIX
make && make install
