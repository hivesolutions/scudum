VERSION=${VERSION-GIT_20161017}

set -e +h

wget --no-check-certificate "http://archive.hive.pt/files/lfs/net-tools-$VERSION.tar.gz"
rm -rf net-tools-$VERSION && tar -zxf "net-tools-$VERSION.tar.gz"
rm -f "net-tools-$VERSION.tar.gz"
cd net-tools-$VERSION

sed -i '/#include <netinet\/ip.h>/d' iptunnel.c

if [ "$SCUDUM_CROSS" == "1" ]; then
    yes "" | ./configure.sh config.in > /dev/null
    make CC="$CC" LD="$LD" && make install
else
    yes "" | make config > /dev/null
    make && make install
fi

mv -v /bin/ifconfig /sbin
