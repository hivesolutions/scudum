VERSION=${VERSION-4.3}
VERSION_L=${VERSION_L-43}
PATCH_SEQ=${PATCH_SEQ-1 33}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/bash/bash-$VERSION.tar.gz"
rm -rf bash-$VERSION && tar -zxf "bash-$VERSION.tar.gz"
rm -f "bash-$VERSION.tar.gz"
cd bash-$VERSION

for index in $(seq -f "%03g" $PATCH_SEQ); do
    wget --no-check-certificate http://ftp.gnu.org/gnu/bash/bash-$VERSION-patches/bash$VERSION_L-$index
    patch -Np0 -i bash$VERSION_L-$index
done

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --bindir=/bin\
    --htmldir=/usr/share/doc/bash-$VERSION\
    --without-bash-malloc\
    --with-installed-readline

make

chown -Rv nobody .
test $TEST && su nobody -s /bin/bash -c "PATH=$PATH make tests"
make install
