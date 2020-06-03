VERSION=${VERSION-2.7.5}

set -e +h

wget --content-disposition "http://ftp.gnu.org/gnu/patch/patch-$VERSION.tar.xz"
rm -rf patch-$VERSION && tar -Jxf "patch-$VERSION.tar.xz"
rm -f "patch-$VERSION.tar.xz"
cd patch-$VERSION

./configure --prefix=$PREFIX
make && make install
