VERSION=${VERSION-1.11.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "python3"

pip3 install --quiet "ninja==$VERSION"
