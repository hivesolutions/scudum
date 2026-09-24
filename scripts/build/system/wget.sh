VERSION=${VERSION-1.25.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/wget/$VERSION/wget-$VERSION.tar.gz"\
    "https://ftpmirror.gnu.org/wget/wget-$VERSION.tar.gz"
rm -rf wget-$VERSION && tar -zxf "wget-$VERSION.tar.gz"
rm -f "wget-$VERSION.tar.gz"
cd wget-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --sysconfdir=/etc\
    --with-ssl=openssl

if [ "$SCUDUM_CROSS" == "1" ]; then
    echo -e "all:\ninstall:" > doc/Makefile
fi

make && make install
