VERSION=${VERSION-4.3}

set -e +h

wget "http://ftp.gnu.org/gnu/bash/bash-$VERSION.tar.gz"
rm -f "bash-$VERSION" && tar -zxf "bash-$VERSION.tar.gz"
rm -f "bash-$VERSION.tar.gz"
cd bash-$VERSION

./configure --prefix=$PREFIX --without-bash-malloc
make && make install

ln -sv bash $PREFIX/bin/sh
