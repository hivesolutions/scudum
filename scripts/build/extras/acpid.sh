VERSION=${VERSION-2.0.34}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "https://mirrors.hive.pt/mirrors/scudum/acpid/$VERSION/acpid-$VERSION.tar.xz"\
    "https://downloads.sourceforge.net/project/acpid2/acpid-$VERSION.tar.xz"\
    "https://downloads.sourceforge.net/acpid2/acpid-$VERSION.tar.xz?use_mirror=netix"\
    "--output-document=acpid-$VERSION.tar.xz"
rm -rf acpid-$VERSION && tar -Jxf "acpid-$VERSION.tar.xz"
rm -f "acpid-$VERSION.tar.xz"
cd acpid-$VERSION

./configure --prefix=$PREFIX
make && make install
