VERSION=${VERSION-3.11.1}

set -e +h

wget --no-check-certificate --content-disposition "https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tgz"
rm -rf Python-$VERSION && tar -zxf "Python-$VERSION.tgz"
rm -f "Python-$VERSION.tgz"
cd Python-$VERSION

./configure --prefix=$PREFIX --enable-shared
make && make install
