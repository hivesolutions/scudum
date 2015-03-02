VERSION=${VERSION-1.0.1l}

set -e +h

unset MAKEFLAGS

export SSL_FLAGS="-DOPENSSL_PIC -DZLIB -DOPENSSL_THREADS -D_REENTRANT -DDSO_DLFCN -DHAVE_DLFCN_H -DL_ENDIAN -DTERMIO\
    -DOPENSSL_BN_ASM_MONT -DOPENSSL_BN_ASM_GF2m -DSHA1_ASM -DSHA256_ASM -DSHA512_ASM -DAES_ASM -DGHASH_ASM"

if [ -z "$CC" ]; then export CC="gcc"; fi
if [ -z "$CFLAGS" ]; then export CFLAGS="-O2"; fi
export CC="$CC $CFLAGS $SSL_FLAGS"

wget --no-check-certificate "https://www.openssl.org/source/openssl-$VERSION.tar.gz"
rm -rf openssl-$VERSION && tar -zxf "openssl-$VERSION.tar.gz"
rm -f "openssl-$VERSION.tar.gz"
cd openssl-$VERSION

if [ "$SCUDUM_CROSS" == "1" ]; then
    ./config shared --prefix=/usr --openssldir=/usr/ssl os/compiler:$ARCH_TARGET-
else
    ./config shared --prefix=/usr --openssldir=/usr/ssl
fi

make && make install

ln -sv /usr/ssl /etc/ssl
