DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libffi"

rm -rf micropython && git clone --depth 1 "https://github.com/micropython/micropython.git"
cd micropython

cd unix
make axtls
make && make PREFIX=$PREFIX install
