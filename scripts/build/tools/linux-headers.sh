VERSION=${VERSION-3.18.5}

set -e +h

wget "https://www.kernel.org/pub/linux/kernel/v3.x/linux-$VERSION.tar.xz"
rm -rf linux-$VERSION && tar -Jxf "linux-$VERSION.tar.xz"
rm -f "linux-$VERSION.tar.xz"
cd linux-$VERSION

make mrproper
make headers_check
make INSTALL_HDR_PATH=dest headers_install

cp -rv dest/include/* $PREFIX/include
