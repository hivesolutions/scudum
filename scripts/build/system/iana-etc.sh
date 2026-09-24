VERSION=${VERSION-20260805}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/iana-etc/$VERSION/iana-etc-$VERSION.tar.gz"\
    "https://github.com/Mic92/iana-etc/releases/download/$VERSION/iana-etc-$VERSION.tar.gz"
rm -rf iana-etc-$VERSION && tar -zxf "iana-etc-$VERSION.tar.gz"
rm -f "iana-etc-$VERSION.tar.gz"
cd iana-etc-$VERSION

cp -v services protocols /etc
