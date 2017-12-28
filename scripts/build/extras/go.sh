VERSION=${VERSION-1.9.2}
VERSION_LEGACY=${VERSION_LEGACY-1.4.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "https://storage.googleapis.com/golang/go$VERSION_LEGACY.src.tar.gz"
rm -rf go && tar -zxf "go$VERSION_LEGACY.src.tar.gz"
rm -f "go$VERSION_LEGACY.src.tar.gz"
rm -rf $PREFIX/go_legacy && mv go go_legacy && mv go_legacy $PREFIX

pushd $PREFIX/go_legacy/src
    ./make.bash
popd

wget "https://storage.googleapis.com/golang/go$VERSION.src.tar.gz"
rm -rf go && tar -zxf "go$VERSION.src.tar.gz"
rm -f "go$VERSION.src.tar.gz"
rm -rf $PREFIX/go && mv go $PREFIX

pushd $PREFIX/go/src
    GOROOT_BOOTSTRAP=$PREFIX/go_legacy ./make.bash
popd

rm -rf $PREFIX/go_legacy

mkdir -pv $PREFIX/bin

ln -svf ../go/bin/go $PREFIX/bin/go
ln -svf ../go/bin/gofmt $PREFIX/bin/gofmt
