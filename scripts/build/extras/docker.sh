VERSION=${VERSION-latest}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "iptables"

wget "https://get.docker.com/builds/Linux/x86_64/docker-$VERSION.tgz"

tar -zxf "docker-$VERSION.tgz"
rm -f "docker-$VERSION.tgz"
chmod +x docker/docker*
mkdir -pv $PREFIX/bin
mv -v docker/docker* $PREFIX/bin
