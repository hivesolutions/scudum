VERSION=${VERSION-3.8.2}

wget -q "https://www.kernel.org/pub/linux/kernel/v3.x/linux-$VERSION.tar.bz2"
rm -rf linux-$VERSION && tar -jxf "linux-$VERSION.tar.bz2"
rm -f "linux-$VERSION.tar.bz2"
cd linux-$VERSION

make mrproper
make headers_check
make INSTALL_HDR_PATH=dest headers_install
cp -rv dest/include/* /tools/include
