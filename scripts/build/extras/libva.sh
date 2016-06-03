VERSION=${VERSION-1.7.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libdrm"

wget "http://www.freedesktop.org/software/vaapi/releases/libva/libva-$VERSION.tar.bz2"
rm -rf libva-$VERSION && tar -jxf "libva-$VERSION.tar.bz2"
rm -f "libva-$VERSION.tar.bz2"
cd libva-$VERSION

mkdir -p m4 && autoreconf -f
./configure --prefix=$PREFIX
make && make install

cd ..

wget http://www.freedesktop.org/software/vaapi/releases/libva-intel-driver/libva-intel-driver-$VERSION.tar.bz2
rm -rf libva-intel-driver-$VERSION && tar -jxf "libva-intel-driver-$VERSION.tar.bz2"
rm -f "libva-intel-driver-$VERSION.tar.bz2"
cd libva-intel-driver-$VERSION

mkdir -p m4 && autoreconf -f
./configure --prefix=$PREFIX
make && make install
