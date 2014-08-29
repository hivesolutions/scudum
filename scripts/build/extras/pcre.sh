VERSION=${VERSION-8.3.5}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget --no-check-certificate "ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-$VERSION.tar.gz"
rm -rf pcre-$VERSION && tar -zxf "pcre-$VERSION.tgz"
rm -f "pcre-$VERSION.tar.xz"
cd pcre-$VERSION

./configure --prefix=$PREFIX
make && make install
