VERSION=${VERSION-4.3}
VERSION_L=${VERSION_L-43}
PATCH_SEQ=${PATCH_SEQ-1 42}

set -e +h

wget "http://ftp.gnu.org/gnu/bash/bash-$VERSION.tar.gz"
rm -f "bash-$VERSION" && tar -zxf "bash-$VERSION.tar.gz"
rm -f "bash-$VERSION.tar.gz"
cd bash-$VERSION

for index in $(seq -f "%03g" $PATCH_SEQ); do
    wget http://ftp.gnu.org/gnu/bash/bash-$VERSION-patches/bash$VERSION_L-$index
    patch -Np0 -i bash$VERSION_L-$index
done

./configure --prefix=$PREFIX --without-bash-malloc
make && make install

ln -sv bash $PREFIX/bin/sh
