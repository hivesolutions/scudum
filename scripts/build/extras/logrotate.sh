VERSION=${VERSION-3.9.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "popt"

wget "https://fedorahosted.org/releases/l/o/logrotate/logrotate-$VERSION.tar.gz"
rm -rf logrotate-$VERSION && tar -zxf "logrotate-$VERSION.tar.gz"
rm -f "logrotate-$VERSION.tar.gz"
cd logrotate-$VERSION

if [ "$SCUDUM_CROSS" == "1" ]; then
    ./autogen.sh && ./configure --host=$ARCH_TARGET --prefix=$PREFIX
else
    ./autogen.sh && ./configure --prefix=$PREFIX
fi

make && make install
