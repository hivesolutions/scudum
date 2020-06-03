VERSION=${VERSION-2.03}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

     https://phoenixnap.dl.sourceforge.net/project/re-alpine/re-alpine-2.02.tar.bz2
wget --content-disposition "http://download.sourceforge.net/project/re-alpine/re-alpine-$VERSION.tar.bz2?use_mirror=netcologne"
rm -rf re-alpine-$VERSION && tar -jxf "re-alpine-$VERSION.tar.bz2"
rm -f "re-alpine-$VERSION.tar.bz2"
cd re-alpine-$VERSION

./configure --prefix=$PREFIX
make && make install
