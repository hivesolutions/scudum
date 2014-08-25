VERSION="1.22.2"
tar -zxf "groff-$VERSION.tar.gz"
cd groff-$VERSION

PAGE=letter ./configure --prefix=/usr
make
mkdir -p /usr/share/doc/groff-1.22/pdf
make install

ln -sv eqn /usr/bin/geqn
ln -sv tbl /usr/bin/gtbl

cd ..
rm -rf groff-$VERSION
