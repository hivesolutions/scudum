VERSION=${VERSION-5.17.4}
VERSION_L=${VERSION_L-5.x}

set -e +h

wget --no-check-certificate --content-disposition "https://www.kernel.org/pub/linux/kernel/v$VERSION_L/linux-$VERSION.tar.xz"
rm -rf linux-$VERSION && tar -Jxf "linux-$VERSION.tar.xz"
rm -f "linux-$VERSION.tar.xz"
cd linux-$VERSION

make mrproper

cp /boot/config .config
make && make modules_install INSTALL_MOD_PATH=modules_install

cd ..

mkdir -p $PREFIX/src
mv -v linux-$VERSION $PREFIX/src/linux
