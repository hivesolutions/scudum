VERSION=${VERSION-4.89}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "https://www.mirrorservice.org/sites/lsof.itap.purdue.edu/pub/tools/unix/lsof/lsof_$VERSION.tar.bz2"
rm -rf lsof_$VERSION && tar -jxf "lsof_$VERSION.tar.bz2"
rm -f "lsof_$VERSION.tar.bz2"
cd lsof_$VERSION

tar -xf lsof_${VERSION}_src.tar
cd lsof_${VERSION}_src

./Configure -n linux
make
install -v -m0755 -o root -g root lsof /usr/bin
