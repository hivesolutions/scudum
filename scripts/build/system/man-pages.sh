VERSION=${VERSION-6.18}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/man-pages/$VERSION/man-pages-$VERSION.tar.xz"\
    "https://www.kernel.org/pub/linux/docs/man-pages/man-pages-$VERSION.tar.xz"
rm -rf man-pages-$VERSION && tar -Jxf "man-pages-$VERSION.tar.xz"
rm -f "man-pages-$VERSION.tar.xz"
cd man-pages-$VERSION

rm -v man3/crypt*

make -R GIT=false prefix=/usr install
