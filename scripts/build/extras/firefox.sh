VERSION=${VERSION-32.0.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "alsa" "gtk+2" "zip" "unzip"

wget "http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/$VERSION/source/firefox-$VERSION.source.tar.bz2"
rm -rf firefox-$VERSION && tar -jxf "firefox-$VERSION.source.tar.bz2"
rm -f "firefox-$VERSION.source.tar.bz2"
cd firefox-$VERSION

cat > mozconfig << "EOF"
# If you have a multicore machine, firefox will now use all the cores by
# default. Exceptionally, you can reduce the number of cores, e.g. to 1,
# by uncommenting the next line and setting a valid number of CPU cores.
#mk_add_options MOZ_MAKE_FLAGS="-j1"

# If you have installed DBus-Glib comment out this line:
ac_add_options --disable-dbus

# If you have installed dbus-glib, and you have installed (or will install)
# wireless-tools, and you wish to use geolocation web services, comment out
# this line
ac_add_options --disable-necko-wifi

# If you have installed libnotify comment out this line:
ac_add_options --disable-libnotify

# GStreamer is necessary for H.264 video playback in HTML5 Video Player;
# to be enabled, also remember to set "media.gstreamer.enabled" to "true"
# in about:config. If you do *not* have GStreamer 0.x.y, uncomment this line:
#ac_add_options --disable-gstreamer
# or uncomment this line, if you have GStreamer 1.x.y
#ac_add_options --enable-gstreamer=1.0

# Uncomment these lines if you have installed optional dependencies:
#ac_add_options --enable-system-hunspell
#ac_add_options --enable-startup-notification

# Comment out following option if you have PulseAudio installed
ac_add_options --disable-pulseaudio

# If you have not installed Yasm then uncomment this line:
#ac_add_options --disable-webm

# Comment out following options if you have not installed
# recommended dependencies:
ac_add_options --enable-system-sqlite
ac_add_options --with-system-libevent
ac_add_options --with-system-libvpx
ac_add_options --with-system-nspr
ac_add_options --with-system-nss
ac_add_options --with-system-icu

# The BLFS editors recommend not changing anything below this line:
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
ac_add_options --with-system-png
ac_add_options --with-system-zlib

mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/firefox-build-dir
EOF

test $(uname -m) = "i686" && sed -i 's/enable-optimize/disable-optimize/' mozconfig || true
make -f client.mk && make -f client.mk install INSTALL_SDK=

mkdir -pv $PREFIX/lib/mozilla/plugins
ln -sfv ../mozilla/plugins $PREFIX/lib/firefox-$VERSION
