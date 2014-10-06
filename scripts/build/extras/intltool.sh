VERSION=${VERSION-0.50.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "https://launchpad.net/intltool/trunk/$VERSION/+download/intltool-$VERSION.tar.gz"
rm -rf intltool-$VERSION && tar -zxf "intltool-$VERSION.tar.gz"
rm -f "intltool-$VERSION.tar.gz"
cd intltool-$VERSION

./configure --prefix=$PREFIX
make && make install
