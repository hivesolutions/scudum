VERSION=${VERSION-0.19.8.1}

set -e +h

wget "http://ftp.gnu.org/gnu/gettext/gettext-$VERSION.tar.gz"
rm -rf "gettext-$VERSION" && tar -zxf "gettext-$VERSION.tar.gz"
rm -f "gettext-$VERSION.tar.xz"
cd gettext-$VERSION

cd gettext-tools
EMACS="no" ./configure --prefix=$PREFIX --disable-shared
make -C gnulib-lib
make -C intl pluralx.c
make -C src msgfmt
make -C src msgmerge
make -C src xgettext
cp -v src/{msgfmt,msgmerge,xgettext} /tools/bin
cd ..
