VERSION=${VERSION-1.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/gettext/$VERSION/gettext-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/gettext/gettext-$VERSION.tar.xz"
rm -rf gettext-$VERSION && tar -Jxf "gettext-$VERSION.tar.xz"
rm -f "gettext-$VERSION.tar.xz"
cd gettext-$VERSION

./configure --disable-shared
make

cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /usr/bin
