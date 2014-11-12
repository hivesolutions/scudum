VERSION=${VERSION-3.17.1}

set -e +h

wget --no-check-certificate "https://www.kernel.org/pub/linux/kernel/v3.x/linux-$VERSION.tar.xz"
rm -rf linux-$VERSION && tar -Jxf "linux-$VERSION.tar.xz"
rm -f "linux-$VERSION.tar.xz"
cd linux-$VERSION

make mrproper

cp /boot/config .config
make modules_install INSTALL_MOD_PATH=modules_install

cd ..

mkdir -p $PREFIX/src
mv linux-$VERSION $PREFIX/src/linux
