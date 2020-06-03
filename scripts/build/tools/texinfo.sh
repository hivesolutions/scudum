VERSION=${VERSION-6.4}

set -e +h

wget --content-disposition "http://ftp.gnu.org/gnu/texinfo/texinfo-$VERSION.tar.xz"
rm -rf texinfo-$VERSION && tar -Jxf "texinfo-$VERSION.tar.xz"
rm -f "texinfo-$VERSION.tar.xz"
cd texinfo-$VERSION

./configure --prefix=$PREFIX
make && make install
