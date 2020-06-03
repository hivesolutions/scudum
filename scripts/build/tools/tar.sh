VERSION=${VERSION-1.30}

set -e +h

wget --content-disposition "http://ftp.gnu.org/gnu/tar/tar-$VERSION.tar.bz2"
rm -rf tar-$VERSION && tar -jxf "tar-$VERSION.tar.bz2"
rm -f "tar-$VERSION.tar.bz2"
cd tar-$VERSION

./configure --prefix=$PREFIX
make && make install
