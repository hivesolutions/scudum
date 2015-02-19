VERSION=${VERSION-3.19}

set -e +h

wget "https://www.kernel.org/pub/linux/kernel/v3.x/linux-$VERSION.tar.xz"
rm -rf linux-$VERSION && tar -Jxf "linux-$VERSION.tar.xz"
rm -f "linux-$VERSION.tar.xz"
cd linux-$VERSION

make mrproper
make ARCH=$SCUDUM_ARCH headers_check
make ARCH=$SCUDUM_ARCH INSTALL_HDR_PATH=$PREFIX_CROSS/sysroot/usr headers_install
