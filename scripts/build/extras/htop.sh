VERSION=${VERSION-3.1.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "python"

wget --content-disposition "https://github.com/htop-dev/htop/archive/refs/tags/$VERSION.tar.gz" "--output-document=htop-$VERSION.tar.gz"
rm -rf htop-$VERSION && tar -zxf "htop-$VERSION.tar.gz"
rm -f "htop-$VERSION.tar.gz"
cd htop-$VERSION

./autogen.sh
./configure --prefix=$PREFIX
make && make install
