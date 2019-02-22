VERSION=${VERSION-5.35}

set -e +h

rget "ftp://ftp.astron.com/pub/file/file-$VERSION.tar.gz"
    "https://src.fedoraproject.org/lookaside/pkgs/file/file-$VERSION.tar.gz
rm -rf file-$VERSION && tar -zxf "file-$VERSION.tar.gz"
rm -f "file-$VERSION.tar.gz"
cd file-$VERSION

./configure --prefix=$PREFIX
make && make install
