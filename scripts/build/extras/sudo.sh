VERSION=${VERSION-1.8.9p3}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget "http://www.sudo.ws/sudo/dist/sudo-$VERSION.tar.gz"
rm -rf sudo-$VERSION && tar -zxf "sudo-$VERSION.tar.gz"
rm -f "sudo-$VERSION.tar.gz"
cd sudo-$VERSION

./configure --prefix=$PREFIX
make && make install
