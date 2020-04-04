VERSION=${VERSION-1.0.2u}
VERSION_L=${VERSION_L-1.0.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

unset MAKEFLAGS TEST

rgeti "https://www.openssl.org/source/old/$VERSION_L/openssl-$VERSION.tar.gz"\
    "http://mirrors.ibiblio.org/openssl/source/old/$VERSION_L/openssl-$VERSION.tar.gz"
rm -rf openssl-$VERSION && tar -zxf "openssl-$VERSION.tar.gz"
rm -f "openssl-$VERSION.tar.gz"
cd openssl-$VERSION

if [ "$SCUDUM_CROSS" == "1" ]; then
    case "$SCUDUM_ARCH" in
        arm*)
            ./Configure linux-generic32 shared --prefix=/usr --openssldir=/usr/ssl
            make && make install
            ;;
        *)
            ./config shared --prefix=/usr --openssldir=/usr/ssl os/compiler:$ARCH_TARGET-gcc
            make depend && make && make install
            ;;
    esac
else
    ./config shared --prefix=/usr --openssldir=/usr/ssl
    make depend && make && make install
fi

ln -svf /usr/ssl /etc/ssl
