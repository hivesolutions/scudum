VERSION=${VERSION-0.64.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "python3" "ninja"

pip3 install --quiet "meson==$VERSION"
