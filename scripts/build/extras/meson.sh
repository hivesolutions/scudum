VERSION=${VERSION-0.54.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "python3" "ninja" "libffi"

pip3 install --quiet "meson==$VERSION"
