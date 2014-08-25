VERSION="2.30"
tar -jxf "iana-etc-$VERSION.tar.bz2"
cd iana-etc-$VERSION

make && make install

cd ..
rm -rf iana-etc-$VERSION
