VERSION=${VERSION-1.4.4}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "https://github.com/facebook/zstd/releases/download/v$VERSION/zstd-$VERSION.tar.gz"
rm -rf zstd-$VERSION && tar -zxf "zstd-$VERSION.tar.gz"
rm -f "zstd-$VERSION.tar.gz"
cd zstd-$VERSION

./configure --prefix=$PREFIX
make && make install