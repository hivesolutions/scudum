VERSION=${VERSION-2.10}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/net-tools/$VERSION/net-tools-$VERSION.tar.xz"\
    "https://downloads.sourceforge.net/project/net-tools/net-tools-$VERSION.tar.xz"\
    "--output-document=net-tools-$VERSION.tar.xz"
rm -rf net-tools-$VERSION && tar -Jxf "net-tools-$VERSION.tar.xz"
rm -f "net-tools-$VERSION.tar.xz"
cd net-tools-$VERSION

if [ "$SCUDUM_CROSS" == "1" ]; then
    yes "" | ./configure.sh config.in > /dev/null
else
    yes "" | make config > /dev/null
fi

sed -e /ROM/s/1/0/\
    -e /X25/s/1/0/\
    -e /ROSE/s/1/0/\
    -i config.h

if [ "$SCUDUM_CROSS" == "1" ]; then
    make CC="$CC" LD="$LD" && make install
else
    make && make install
fi

mv -v /usr/bin/ifconfig /usr/sbin
