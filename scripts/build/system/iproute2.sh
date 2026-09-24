VERSION=${VERSION-7.1.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/iproute2/$VERSION/iproute2-$VERSION.tar.xz"\
    "https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-$VERSION.tar.xz"
rm -rf iproute2-$VERSION && tar -Jxf "iproute2-$VERSION.tar.xz"
rm -f "iproute2-$VERSION.tar.xz"
cd iproute2-$VERSION

sed -i /ARPD/d Makefile
rm -fv man/man8/arpd.8

if [ "$SCUDUM_CROSS" == "1" ]; then
    make CC="$CC" HOSTCC=gcc NETNS_RUN_DIR=/run/netns
    make CC="$CC" HOSTCC=gcc SBINDIR=/usr/sbin install
else
    make NETNS_RUN_DIR=/run/netns
    make SBINDIR=/usr/sbin install
fi

install -vDm644 COPYING README* -t /usr/share/doc/iproute2-$VERSION
