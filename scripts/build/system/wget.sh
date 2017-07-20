VERSION=${VERSION-1.19.1}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/wget/wget-$VERSION.tar.gz"
rm -rf wget-$VERSION && tar -zxf "wget-$VERSION.tar.gz"
rm -f "wget-$VERSION.tar.gz"
cd wget-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr --with-ssl=openssl

if [ "$SCUDUM_CROSS" == "1" ]; then
    echo -e "all:\ninstall:" > doc/Makefile
fi

make && make install
