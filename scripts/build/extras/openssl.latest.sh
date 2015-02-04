VERSION=${VERSION-1.0.1l}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

unset MAKEFLAGS

wget --no-check-certificate "https://www.openssl.org/source/openssl-$VERSION.tar.gz"
rm -rf openssl-$VERSION && tar -zxf "openssl-$VERSION.tar.gz"
rm -f "openssl-$VERSION.tar.gz"
cd openssl-$VERSION

cat > openssl.ld  << "EOF"
OPENSSL_1.0.0 {
    global:
    *;
};
EOF

./config shared --prefix=/usr --openssldir=/usr/ssl\
    -Wl,--version-script=openssl.ld -Wl,-Bsymbolic-functions
make && make install

ln -sv /usr/ssl /etc/ssl
