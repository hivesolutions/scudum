DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "nss-mdns"

/usr/sbin/avahi-daemon -D

echo "mDNS should now be running"
