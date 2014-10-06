DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

XORG_CONFIG="--prefix=$PREFIX --sysconfdir=/etc\
    --localstatedir=/var --disable-static"

rm -rf xorg-protocol && mkdir -p xorg-protocol
cd xorg-protocol

cat > xorg-protocol.md5 << "EOF"
1a05fb01fa1d5198894c931cf925c025  bigreqsproto-1.1.2.tar.bz2
98482f65ba1e74a08bf5b056a4031ef0  compositeproto-0.4.2.tar.bz2
998e5904764b82642cc63d97b4ba9e95  damageproto-1.2.1.tar.bz2
4ee175bbd44d05c34d43bb129be5098a  dmxproto-2.3.1.tar.bz2
b2721d5d24c04d9980a0c6540cb5396a  dri2proto-2.8.tar.bz2
a3d2cbe60a9ca1bf3aea6c93c817fee3  dri3proto-1.0.tar.bz2
e7431ab84d37b2678af71e29355e101d  fixesproto-5.0.tar.bz2
c5f4f1fb4ba7766eedbc9489e81f3be2  fontsproto-2.1.2.tar.bz2
5565f1b0facf4a59c2778229c1f70d10  glproto-1.4.17.tar.bz2
94db391e60044e140c9854203d080654  inputproto-2.3.tar.bz2
677ea8523eec6caca86121ad2dca0b71  kbproto-1.0.6.tar.bz2
2d569c75884455c7148d133d341e8fd6  presentproto-1.0.tar.bz2
ce4d0b05675968e4c83e003cc809660d  randrproto-1.4.0.tar.bz2
1b4e5dede5ea51906f1530ca1e21d216  recordproto-1.14.2.tar.bz2
a914ccc1de66ddeb4b611c6b0686e274  renderproto-0.11.1.tar.bz2
cfdb57dae221b71b2703f8e2980eaaf4  resourceproto-1.2.0.tar.bz2
edd8a73775e8ece1d69515dd17767bfb  scrnsaverproto-1.2.2.tar.bz2
e658641595327d3990eab70fdb55ca8b  videoproto-2.3.2.tar.bz2
5f4847c78e41b801982c8a5e06365b24  xcmiscproto-1.2.2.tar.bz2
70c90f313b4b0851758ef77b95019584  xextproto-7.3.0.tar.bz2
120e226ede5a4687b25dd357cc9b8efe  xf86bigfontproto-1.2.0.tar.bz2
a036dc2fcbf052ec10621fd48b68dbb1  xf86dgaproto-2.1.tar.bz2
1d716d0dac3b664e5ee20c69d34bc10e  xf86driproto-2.1.1.tar.bz2
e793ecefeaecfeabd1aed6a01095174e  xf86vidmodeproto-2.3.1.tar.bz2
9959fe0bfb22a0e7260433b8d199590a  xineramaproto-1.2.1.tar.bz2
28311ef4edbbbf89f617a7f8a2e5648f  xproto-7.0.25.tar.bz2
EOF

mkdir proto && cd proto
grep -v '^#' ../xorg-protocol.md5 | awk '{print $2}' | wget -i- -c \
    -B http://xorg.freedesktop.org/releases/individual/proto/
md5sum -c ../xorg-protocol.md5

for package in $(grep -v '^#' ../proto-7.7.md5 | awk '{print $2}'); do
    packagedir=${package%.tar.bz2}
    tar -xf $package
    pushd $packagedir
    ./configure $XORG_CONFIG
    make install
    popd
    rm -rf $packagedir
done
