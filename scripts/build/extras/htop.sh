VERSION=${VERSION-1.0.3}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget --no-check-certificate "http://hisham.hm/htop/releases/$VERSION/htop-$VERSION.tar.gz"
rm -rf htop-$VERSION && tar -zxf "htop-$VERSION.tar.gz"
rm -f "htop-$VERSION.tar.gz"
cd htop-$VERSION

./configure --prefix=$PREFIX
make && make install
