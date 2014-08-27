VERSION=${VERSION-2.7.8}

set -e

wget --no-check-certificate "https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tgz"
rm -rf "Python-$VERSION" && tar -zxf "Python-$VERSION.tgz"
rm -f "Python-$VERSION.tar.xz"
cd Python-$VERSION

./configure --prefix=/usr
make && make install
