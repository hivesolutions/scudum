VERSION=${VERSION-2.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libnl"

wget "http://hostap.epitest.fi/releases/wpa_supplicant-$VERSION.tar.gz"
rm -rf wpa_supplicant-$VERSION && tar -zxf "wpa_supplicant-$VERSION.tar.gz"
rm -f "wpa_supplicant-$VERSION.tar.gz"
cd wpa_supplicant-$VERSION

cat > wpa_supplicant/.config << "EOF"
CONFIG_BACKEND=file
CONFIG_CTRL_IFACE=y
CONFIG_DEBUG_FILE=y
CONFIG_DEBUG_SYSLOG=y
CONFIG_DEBUG_SYSLOG_FACILITY=LOG_DAEMON
CONFIG_DRIVER_NL80211=y
CONFIG_DRIVER_WEXT=y
CONFIG_DRIVER_WIRED=y
CONFIG_EAP_GTC=y
CONFIG_EAP_LEAP=y
CONFIG_EAP_MD5=y
CONFIG_EAP_MSCHAPV2=y
CONFIG_EAP_OTP=y
CONFIG_EAP_PEAP=y
CONFIG_EAP_TLS=y
CONFIG_EAP_TTLS=y
CONFIG_IEEE8021X_EAPOL=y
CONFIG_IPV6=y
CONFIG_LIBNL32=y
CONFIG_PEERKEY=y
CONFIG_PKCS12=y
CONFIG_READLINE=y
CONFIG_SMARTCARD=y
CONFIG_WPS=y
CFLAGS += -I/usr/include/libnl3
EOF

cd wpa_supplicant

if [ "$SCUDUM_CROSS" == "1" ]; then
    if [ -z "$CFLAGS" ]; then export CFLAGS="-O2"; fi
    make CC=$CC CFLAGS="$CFLAGS" BINDIR=$PREFIX/bin LIBDIR=$PREFIX/lib C_INCLUDE_PATH=$C_INCLUDE_PATH:$PREFIX/include/libnl3
else
    make BINDIR=$PREFIX/bin LIBDIR=$PREFIX/lib C_INCLUDE_PATH=$C_INCLUDE_PATH:$PREFIX/include/libnl3
fi

mkdir -p $PREFIX/bin
mkdir -p $PREFIX/share

install -v -m755 wpa_{cli,passphrase,supplicant} $PREFIX/bin
install -v -m644 doc/docbook/wpa_supplicant.conf.5 $PREFIX/share/man/man5
install -v -m644 doc/docbook/wpa_{cli,passphrase,supplicant}.8 $PREFIX/share/man/man8
