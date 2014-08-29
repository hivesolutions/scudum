VERSION=${VERSION-latest}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget --no-check-certificate "https://get.docker.io/builds/Linux/x86_64/docker-$VERSION"
chmod +x docker-$VERSION && install docker-$VERSION $PREFIX/bin
