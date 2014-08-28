VERSION=${VERSION-4.2}

set -e

wget --no-check-certificate "http://ftp.gnu.org/gnu/bash/bash-$VERSION.tar.gz"
rm -rf bash-$VERSION && tar -zxf "bash-$VERSION.tar.gz"
rm -f "bash-$VERSION.tar.gz"
cd bash-$VERSION

wget --no-check-certificate "http://www.linuxfromscratch.org/patches/lfs/7.3/bash-$VERSION-fixes-11.patch"
patch -Np1 -i bash-$VERSION-fixes-11.patch

./configure\
    --prefix=/usr\
    --bindir=/bin\
    --htmldir=/usr/share/doc/bash-$VERSION\
    --without-bash-malloc\
    --with-installed-readline
    
make

chown -Rv nobody .
test $TEST && su nobody -s /bin/bash -c "PATH=$PATH make tests"
make install
