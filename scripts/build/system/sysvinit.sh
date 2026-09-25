VERSION=${VERSION-3.14}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/sysvinit/$VERSION/sysvinit-$VERSION.tar.xz"\
    "https://github.com/slicer69/sysvinit/releases/download/$VERSION/sysvinit-$VERSION.tar.xz"
rgeti "https://mirrors.hive.pt/mirrors/scudum/sysvinit/$VERSION/sysvinit-$VERSION-consolidated-1.patch"\
    "https://www.linuxfromscratch.org/patches/lfs/12.4/sysvinit-$VERSION-consolidated-1.patch"
rm -rf sysvinit-$VERSION && tar -Jxf "sysvinit-$VERSION.tar.xz"
rm -f "sysvinit-$VERSION.tar.xz"
cd sysvinit-$VERSION

patch -Np1 -i ../sysvinit-$VERSION-consolidated-1.patch

make
make install
