VERSION=${VERSION-latest}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "open-isns" "systemd"

if [ "$VERSION" == "latest" ]; then
    rm -rf open-iscsi && git clone --depth 1 "https://github.com/open-iscsi/open-iscsi.git"
    cd open-iscsi
else
    wget "https://github.com/open-iscsi/open-iscsi/archive/$VERSION.tar.gz"
    rm -rf open-iscsi-$VERSION && tar -zxf "$VERSION.tar.gz"
    rm -f "$VERSION.tar.gz"
    cd open-iscsi-$VERSION
fi

make && make install
