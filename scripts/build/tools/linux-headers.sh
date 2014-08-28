VERSION=${VERSION-3.13.3}

set -e

wget "https://www.kernel.org/pub/linux/kernel/v3.x/linux-$VERSION.tar.xz"
rm -rf linux-$VERSION && tar -Jxf "linux-$VERSION.tar.xz"
rm -f "linux-$VERSION.tar.xz"
cd linux-$VERSION

make mrproper
make headers_check
make INSTALL_HDR_PATH=dest headers_install

cp -rv dest/include/* /tools/include
