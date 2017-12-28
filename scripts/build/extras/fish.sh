VERSION=${VERSION-2.7.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "https://fishshell.com/files/$VERSION/fish-$VERSION.tar.gz"
rm -rf fish-$VERSION && tar -zxf "fish-$VERSION.tar.gz"
rm -f "fish-$VERSION.tar.gz"
cd fish-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX
make && make install

echo "$PREFIX/bin/fish" >> /etc/shells
