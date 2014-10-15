VERSION=${VERSION-32.0.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "alsa" "gtk+2" "zip" "unzip" "sqlite3" "yasm" "dbus-glib" "gstreamer-plugins"

wget "http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/$VERSION/source/firefox-$VERSION.source.tar.bz2"
rm -rf mozilla-release && tar -jxf "firefox-$VERSION.source.tar.bz2"
rm -f "firefox-$VERSION.source.tar.bz2"
cd mozilla-release

cat > mozconfig << "EOF"
ac_add_options --disable-necko-wifi
ac_add_options --disable-libnotify
ac_add_options --disable-pulseaudio

ac_add_options --enable-gstreamer=1.0
ac_add_options --enable-system-sqlite

ac_add_options --prefix=$PREFIX
ac_add_options --enable-application=browser

ac_add_options --disable-crashreporter
ac_add_options --disable-updater
ac_add_options --disable-tests

ac_add_options --enable-optimize
ac_add_options --enable-strip
ac_add_options --enable-install-strip

ac_add_options --enable-gio
ac_add_options --enable-official-branding
ac_add_options --enable-safe-browsing
ac_add_options --enable-url-classifier

ac_add_options --enable-system-cairo
ac_add_options --enable-system-ffi
ac_add_options --enable-system-pixman

ac_add_options --with-pthreads

ac_add_options --with-system-bz2
ac_add_options --with-system-jpeg
ac_add_options --without-system-png
ac_add_options --with-system-zlib

mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/firefox-build-dir
EOF

test $(uname -m) = "i686" && sed -i 's/enable-optimize/disable-optimize/' mozconfig || true
make -f client.mk SHELL=/bin/bash && make -f client.mk install SHELL=/bin/bash INSTALL_SDK=

mkdir -pv $PREFIX/lib/mozilla/plugins
ln -sfv mozilla/plugins $PREFIX/lib/firefox-$VERSION
