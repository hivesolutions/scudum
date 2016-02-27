VERSION=${VERSION-4.4.3}
VERSION_L=${VERSION_L-4.x}

set -e +h

wget "https://www.kernel.org/pub/linux/kernel/v$VERSION_L/linux-$VERSION.tar.xz"
rm -rf linux-$VERSION && tar -Jxf "linux-$VERSION.tar.xz"
rm -f "linux-$VERSION.tar.xz"
cd linux-$VERSION

make mrproper
make ARCH=$SCUDUM_BARCH headers_check
make ARCH=$SCUDUM_BARCH INSTALL_HDR_PATH=dest headers_install

mkdir -p $PREFIX_CROSS/sysroot/usr/include
cp -rv dest/include/* $PREFIX_CROSS/sysroot/usr/include
