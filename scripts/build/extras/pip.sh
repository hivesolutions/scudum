DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

rm -f get-pip.py && wget "https://bootstrap.pypa.io/get-pip.py"
python get-pip.py --user
