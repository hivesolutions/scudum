DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "lvm2"

rm -rf multipath-tools && git clone "http://git.opensvc.com/multipath-tools/.git"
cd multipath-tools/kpartx

make && make install DESTDIR=$PREFIX
