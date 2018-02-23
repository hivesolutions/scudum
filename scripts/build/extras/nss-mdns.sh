VERSION=${VERSION-0.13.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "avahi" "glib"

wget "https://github.com/lathiat/nss-mdns/releases/download/v$VERSION/nss-mdns-$VERSION.tar.gz"
rm -rf nss-mdns-$VERSION && tar -zxf "nss-mdns-$VERSION.tar.gz"
rm -f "nss-mdns-$VERSION.tar.gz"
cd nss-mdns-$VERSION

./configure --prefix=$PREFIX

make && make install

cat > /etc/mdns.allow << "EOF"
# /etc/mdns.allow
*
EOF
