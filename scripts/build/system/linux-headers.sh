VERSION=${VERSION-5.4.44}
VERSION_L=${VERSION_L-5.x}

set -e +h

wget --no-check-certificate --content-disposition "https://www.kernel.org/pub/linux/kernel/v$VERSION_L/linux-$VERSION.tar.xz"
rm -rf linux-$VERSION && tar -Jxf "linux-$VERSION.tar.xz"
rm -f "linux-$VERSION.tar.xz"
cd linux-$VERSION

make mrproper
make ARCH=$SCUDUM_BARCH headers_check
make ARCH=$SCUDUM_BARCH INSTALL_HDR_PATH=dest headers_install

find dest/include \( -name .install -o -name ..install.cmd \) -delete
cp -rv dest/include/* /usr/include
