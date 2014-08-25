VERSION=${VERSION-4.2}

wget -q "http://ftp.gnu.org/gnu/bash/bash-$VERSION.tar.gz"
tar -zxf "bash-$VERSION.tar.gz"
rm -f "bash-$VERSION.tar.gz"
cd bash-$VERSION

wget -q "http://www.linuxfromscratch.org/patches/lfs/7.3/bash-$VERSION-fixes-11.patch"
patch -Np1 -i bash-$VERSION-fixes-11.patch

./configure --prefix=$PREFIX --without-bash-malloc
make && make install

ln -sv bash $PREFIX/bin/sh
