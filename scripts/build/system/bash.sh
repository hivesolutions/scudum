VERSION=${VERSION-4.3}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/bash/bash-$VERSION.tar.gz"
rm -rf bash-$VERSION && tar -zxf "bash-$VERSION.tar.gz"
rm -f "bash-$VERSION.tar.gz"
cd bash-$VERSION

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
