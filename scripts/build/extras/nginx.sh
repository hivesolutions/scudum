VERSION=${VERSION-1.9.4}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://nginx.org/download/nginx-$VERSION.tar.gz"
rm -rf nginx-$VERSION && tar -zxf "nginx-$VERSION.tar.gz"
rm -f "nginx-$VERSION.tar.gz"
cd nginx-$VERSION

./configure\
    --prefix=$PREFIX/nginx\
    --sbin-path=$PREFIX/sbin/nginx\
    --conf-path=/etc/nginx/nginx.conf\
    --pid-path=/var/run/nginx.pid\
    --error-log-path=/var/log/nginx/error.log\
    --http-log-path=/var/log/nginx/access.log\
    --with-http_ssl_module

make && make install
