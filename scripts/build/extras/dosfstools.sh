VERSION=${VERSION-3.0.26}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://daniel-baumann.ch/files/software/dosfstools/dosfstools-$VERSION.tar.gz"
rm -rf dosfstools-$VERSION && tar -zxf "dosfstools-$VERSION.tar.gz"
rm -f "dosfstools-$VERSION.tar.gz"
cd dosfstools-$VERSION

make && make install PREFIX=$PREFIX
