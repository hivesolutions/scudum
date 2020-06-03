VERSION=${VERSION-3.2.1}

set -e +h

wget --content-disposition "http://ftp.gnu.org/gnu/bison/bison-$VERSION.tar.xz"
rm -rf bison-$VERSION && tar -Jxf "bison-$VERSION.tar.xz"
rm -f "bison-$VERSION.tar.xz"
cd bison-$VERSION

./configure --prefix=$PREFIX

make && make install
