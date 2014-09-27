VERSION=${VERSION-latest}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

depends "nodejs"

npm install jade --global
