VERSION=${VERSION-2.6.36}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget --content-disposition "http://downloads.sourceforge.net/project/gkernel/ethtool-$VERSION.tar.gz?use_mirror=netcologne"
rm -rf ethtool-$VERSION && tar -zxf "ethtool-$VERSION.tar.gz"
rm -f "ethtool-$VERSION.tar.gz"
cd ethtool-$VERSION

./configure --prefix=$PREFIX
make && make install
