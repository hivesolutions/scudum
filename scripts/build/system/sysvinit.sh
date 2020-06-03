VERSION=${VERSION-2.91}

set -e +h

wget --no-check-certificate --content-disposition "http://download.savannah.gnu.org/releases/sysvinit/sysvinit-$VERSION.tar.xz"
rm -rf sysvinit-$VERSION && tar -Jxf "sysvinit-$VERSION.tar.xz"
rm -f "sysvinit-$VERSION.tar.xz"
cd sysvinit-$VERSION

make -C src
make -C src install
