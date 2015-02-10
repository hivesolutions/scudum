VERSION=${VERSION-0.1.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "ftp://mirror.jmu.edu/.projects/blfs/svn/f/fdk-aac-0.1.3.tar.gz"
rm -rf fdk-aac-$VERSION && tar -zxf "fdk-aac-$VERSION.tar.gz"
rm -f "fdk-aac-$VERSION.tar.gz"
cd fdk-aac-$VERSION

./configure --prefix=$PREFIX --disable-static
make && make install
