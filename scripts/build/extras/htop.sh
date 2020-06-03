VERSION=${VERSION-2.2.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "python"

wget --content-disposition "http://hisham.hm/htop/releases/$VERSION/htop-$VERSION.tar.gz"
rm -rf htop-$VERSION && tar -zxf "htop-$VERSION.tar.gz"
rm -f "htop-$VERSION.tar.gz"
cd htop-$VERSION

./configure --prefix=$PREFIX
make && make install
