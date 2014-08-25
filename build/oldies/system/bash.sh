VERSION="4.2"
tar -zxf "bash-$VERSION.tar.gz"
cd bash-$VERSION

patch -Np1 -i ../bash-$VERSION-fixes-11.patch

./configure\
    --prefix=/usr\
    --bindir=/bin\
    --htmldir=/usr/share/doc/bash-$VERSION\
    --without-bash-malloc\
    --with-installed-readline
make

chown -Rv nobody .
su nobody -s /bin/bash -c "PATH=$PATH make tests"
make install
exec /bin/bash --login +h

cd ..
rm -rf bash-$VERSION
