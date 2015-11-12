VERSION=${VERSION-3.0.28}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "https://github.com/dosfstools/dosfstools/releases/download/v$VERSION/dosfstools-$VERSION.tar.gz"
rm -rf dosfstools-$VERSION && tar -zxf "dosfstools-$VERSION.tar.gz"
rm -f "dosfstools-$VERSION.tar.gz"
cd dosfstools-$VERSION

make && make install PREFIX=$PREFIX
