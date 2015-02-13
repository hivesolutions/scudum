DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rm -rf scudum && git clone --depth 1 "https://github.com/hivesolutions/scudum.git"
cd scudum

mkdir -p $PREFIX/bin
mkdir -p $PREFIX/sbin

cp -rp system/bin/* $PREFIX/bin
cp -rp system/sbin/* $PREFIX/sbin

rm -rf $PREFIX/system
cp -rp system $PREFIX

echo "scudum-system: may need to run 'hash -r' to run new binaries"
