VERSION=${VERSION-0.13.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "avahi" "glib"

wget "https://github.com/lathiat/nss-mdns/releases/download/v$VERSION/nss-mdns-$VERSION.tar.gz"
rm -rf nss-mdns-$VERSION && tar -zxf "nss-mdns-$VERSION.tar.gz"
rm -f "nss-mdns-$VERSION.tar.gz"
cd nss-mdns-$VERSION

./configure

make && make install

sed -i 's/hosts: files dns/hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4/' /etc/nsswitch.conf

cat > /etc/mdns.allow << "EOF"
# /etc/mdns.allow
*
EOF
