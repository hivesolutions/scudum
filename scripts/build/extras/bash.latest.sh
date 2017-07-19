VERSION=${VERSION-4.4}
VERSION_L=${VERSION_L-44}
PATCH_SEQ=${PATCH_SEQ-1 12}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://ftp.gnu.org/gnu/bash/bash-$VERSION.tar.gz"
rm -rf bash-$VERSION && tar -zxf "bash-$VERSION.tar.gz"
rm -f "bash-$VERSION.tar.gz"
cd bash-$VERSION

for index in $(seq -f "%03g" $PATCH_SEQ); do
    wget --no-check-certificate http://ftp.gnu.org/gnu/bash/bash-$VERSION-patches/bash$VERSION_L-$index
    patch -Np0 -i bash$VERSION_L-$index
done

./configure\
    --host=$ARCH_TARGET\
    --prefix=$PREFIX\
    --htmldir=/usr/share/doc/bash-$VERSION\
    --without-bash-malloc\
    --with-installed-readline

make && make install
