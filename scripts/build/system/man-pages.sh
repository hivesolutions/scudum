VERSION=${VERSION-5.09}

set -e +h

wget --no-check-certificate --content-disposition "https://www.kernel.org/pub/linux/docs/man-pages/man-pages-$VERSION.tar.xz"
rm -rf man-pages-$VERSION && tar -Jxf "man-pages-$VERSION.tar.xz"
rm -f "man-pages-$VERSION.tar.gz"
cd man-pages-$VERSION

make install
