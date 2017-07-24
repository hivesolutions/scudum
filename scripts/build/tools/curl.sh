[ "$SCUDUM_CROSS" == "0" ] && exit 0 || true

VERSION=${VERSION-7.54.1}

set -e +h

wget "http://curl.haxx.se/download/curl-$VERSION.tar.gz"
rm -rf curl-$VERSION && tar -zxf "curl-$VERSION.tar.gz"
rm -f "curl-$VERSION.tar.gz"
cd curl-$VERSION

sed -i -e 's/$SHELL $CONFIG_STATUS $ac_config_status_args/exit 0/g' configure
./configure --prefix=$PREFIX --with-ca-bundle=/usr/ssl/ca-bundle.crt
bash ./config.status

make && make install
