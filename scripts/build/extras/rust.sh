VERSION=${VERSION-1.22.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "python" "cmake"

wget "https://github.com/rust-lang/rust/archive/$VERSION.tar.gz"
rm -rf rust-$VERSION && tar -zxf "$VERSION.tar.gz"
rm -f "$VERSION.tar.gz"
cd rust-$VERSION

./x.py build && ./x.py install
