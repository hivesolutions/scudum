VERSION=${VERSION-5.0.6}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget "http://www.zsh.org/pub/zsh-$VERSION.tar.bz2"
rm -rf zsh-$VERSION && tar -jxf "zsh-$VERSION.tar.bz2"
rm -f "zsh-$VERSION.tar.bz2"
cd zsh-$VERSION

./configure --prefix=$PREFIX
make && make install
