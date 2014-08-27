VERSION=${VERSION-2.1.0}

set -e

wget --no-check-certificate "https://www.kernel.org/pub/software/scm/git/git-$VERSION.tar.xz"
rm -rf "git-$VERSION" && tar -Jxf "git-$VERSION.tar.gz"
rm -f "git-$VERSION.tar.gz"
cd git-$VERSION

./configure --prefix=/usr
make && make install
