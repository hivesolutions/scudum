VERSION=${VERSION-7.2.7}
VERSION_L=${VERSION_L-7.x}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/linux/$VERSION/linux-$VERSION.tar.xz"\
    "https://www.kernel.org/pub/linux/kernel/v$VERSION_L/linux-$VERSION.tar.xz"
rm -rf linux-$VERSION && tar -Jxf "linux-$VERSION.tar.xz"
rm -f "linux-$VERSION.tar.xz"
cd linux-$VERSION

make mrproper
make ARCH=$SCUDUM_BARCH headers

find usr/include -type f ! -name '*.h' -delete
cp -rv usr/include /usr
