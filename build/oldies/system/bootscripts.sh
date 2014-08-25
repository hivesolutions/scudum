VERSION="20130123"
tar -jxf "lfs-bootscripts-$VERSION.tar.bz2"
cd lfs-bootscripts-$VERSION

make install

cd ..
rm -rf bootscripts-$VERSION
