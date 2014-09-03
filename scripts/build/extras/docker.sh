VERSION=${VERSION-latest}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

depends "iptables"

wget "https://get.docker.io/builds/Linux/x86_64/docker-$VERSION"

chmod +x docker-$VERSION
mkdir -pv $PREFIX/bin
mv docker-$VERSION $PREFIX/bin/docker
