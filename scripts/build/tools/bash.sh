VERSION=${VERSION-4.2}

set -e

wget "http://ftp.gnu.org/gnu/bash/bash-$VERSION.tar.gz"
rm -f "bash-$VERSION" && tar -zxf "bash-$VERSION.tar.gz"
rm -f "bash-$VERSION.tar.gz"
cd bash-$VERSION

wget "http://www.linuxfromscratch.org/patches/lfs/7.3/bash-$VERSION-fixes-11.patch"
patch -Np1 -i bash-$VERSION-fixes-11.patch

./configure --prefix=$PREFIX --without-bash-malloc
make && make install

ln -sv bash $PREFIX/bin/sh
