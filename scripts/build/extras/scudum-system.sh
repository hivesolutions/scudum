DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rm -rf scudum && git clone --depth 1 https://github.com/hivesolutions/scudum.git
cd scudum

mkdir -p $PREFIX/bin
cp -rp system/bin/* $PREFIX/bin

hash -r
