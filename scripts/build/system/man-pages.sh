VERSION=${VERSION-3.71}

wget -q --no-check-certificate "https://www.kernel.org/pub/linux/docs/man-pages/man-pages-$VERSION.tar.xz"

rm -f "man-pages-$VERSION" && tar -Jxf "man-pages-$VERSION.tar.xz"
rm -f "man-pages-$VERSION.tar.gz"
cd man-pages-$VERSION

make install
