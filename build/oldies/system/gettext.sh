VERSION="0.18.2"
tar -zxf "gettext-$VERSION.tar.gz"
cd gettext-$VERSION

./configure\
    --prefix=/usr\
    --docdir=/usr/share/doc/gettext-$VERSION
make
test $TEST && make check
make install

cd ..
rm -rf gettext-$VERSION
