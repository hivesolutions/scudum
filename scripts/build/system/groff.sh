VERSION=${VERSION-1.22.2}

wget --no-check-certificate "http://ftp.gnu.org/gnu/groff/groff-$VERSION.tar.gz"
rm -rf groff-$VERSION && tar -zxf "groff-$VERSION.tar.gz"
rm -f "groff-$VERSION.tar.gz"
cd groff-$VERSION

PAGE=letter ./configure --prefix=/usr

make
mkdir -p /usr/share/doc/groff-1.22/pdf
make install

ln -sv eqn /usr/bin/geqn
ln -sv tbl /usr/bin/gtbl
