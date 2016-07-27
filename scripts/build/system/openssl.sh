VERSION=${VERSION-1.0.2h}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

unset MAKEFLAGS TEST

rgeti "https://www.openssl.org/source/openssl-$VERSION.tar.gz"\
    "http://mirrors.ibiblio.org/openssl/source/openssl-$VERSION.tar.gz"
rm -rf openssl-$VERSION && tar -zxf "openssl-$VERSION.tar.gz"
rm -f "openssl-$VERSION.tar.gz"
cd openssl-$VERSION

if [ "$SCUDUM_CROSS" == "1" ]; then
    case "$SCUDUM_ARCH" in
        arm*)
            ./Configure linux-armv4 shared --prefix=/usr --openssldir=/usr/ssl
            ;;
        *)
            ./config shared --prefix=/usr --openssldir=/usr/ssl os/compiler:$ARCH_TARGET-gcc
            ;;
    esac
else
    ./config shared --prefix=/usr --openssldir=/usr/ssl
fi

make depend && make && make install

ln -svf /usr/ssl /etc/ssl
