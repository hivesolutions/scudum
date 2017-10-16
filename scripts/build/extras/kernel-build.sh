source /etc/scudum/KERNEL

VERSION=${VERSION-$KSUFFIX}
MINOR=${MINOR-$KMINOR}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "https://builds.stage.hive.pt/kernel/kernel-$VERSION.source.tar.gz"
rm -rf linux-$MINOR && tar -zxf "kernel-$VERSION.source.tar.gz"
rm -f "kernel-$VERSION.source.tar.gz"

mkdir -p $PREFIX/linux
rm -rf $PREFIX/linux
cp -rp linux-$MINOR $PREFIX/linux

mkdir -p /opt/src
rm -rf /opt/linux && rm -rf /opt/src/linux
ln -s $PREFIX/linux/linux-$MINOR /opt/src/linux
