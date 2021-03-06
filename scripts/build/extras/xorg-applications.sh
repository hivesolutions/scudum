DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libpng" "mesa" "xbitmaps" "xcb-util" "xcb-util-keysyms"

XORG_CONFIG="--prefix=$PREFIX --sysconfdir=/etc\
    --localstatedir=/var --disable-static"

rm -rf xorg-applications && mkdir -p xorg-applications
cd xorg-applications

cat > xorg-applications.md5 << "EOF"
96a648a332160a7482885800f7a506fa  bdftopcf-1.0.4.tar.bz2
2527344acc60741a709f4858564c5ae6  iceauth-1.0.6.tar.bz2
c4a3664e08e5a47c120ff9263ee2f20c  luit-1.1.1.tar.bz2
18c429148c96c2079edda922a2b67632  mkfontdir-1.0.7.tar.bz2
03de3f15db678e277f5ef9c013aca1ad  mkfontscale-1.1.1.tar.bz2
f548e389ff68424947b87785df6a321b  sessreg-1.0.8.tar.bz2
1001771344608e120e943a396317c33a  setxkbmap-1.3.0.tar.bz2
edce41bd7562dcdfb813e05dbeede8ac  smproxy-1.0.5.tar.bz2
5c3c7431a38775caaea6051312a49bc9  x11perf-1.5.4.tar.bz2
7d6003f32838d5b688e2c8a131083271  xauth-1.0.9.tar.bz2
0066f23f69ca3ef62dcaeb74a87fdc48  xbacklight-1.2.1.tar.bz2
5812be48cbbec1068e7b718eec801766  xcmsdb-1.0.4.tar.bz2
b58a87e6cd7145c70346adad551dba48  xcursorgen-1.0.6.tar.bz2
cacc0733f16e4f2a97a5c430fcc4420e  xdpyinfo-1.3.1.tar.bz2
3d3cad4d754e10e325438193433d59fd  xdriinfo-1.0.4.tar.bz2
5b0a0b6f589441d546da21739fa75634  xev-1.2.1.tar.bz2
c06067f572bc4a5298f324f27340da95  xgamma-1.0.5.tar.bz2
f1669af1fe0554e876f03319c678e79d  xhost-1.0.6.tar.bz2
305980ac78a6954e306a14d80a54c441  xinput-1.6.1.tar.bz2
a0fc1ac3fc4fe479ade09674347c5aa0  xkbcomp-1.2.4.tar.bz2
37ed71525c63a9acd42e7cde211dcc5b  xkbevd-1.1.3.tar.bz2
502b14843f610af977dffc6cbf2102d5  xkbutils-1.0.4.tar.bz2
0ae6bc2a8d3af68e9c76b1a6ca5f7a78  xkill-1.0.4.tar.bz2
9d0e16d116d1c89e6b668c1b2672eb57  xlsatoms-1.1.1.tar.bz2
9fbf6b174a5138a61738a42e707ad8f5  xlsclients-1.1.3.tar.bz2
2dd5ae46fa18abc9331bc26250a25005  xmessage-1.0.4.tar.bz2
5511da3361eea4eaa21427652c559e1c  xmodmap-1.0.8.tar.bz2
6101f04731ffd40803df80eca274ec4b  xpr-1.0.4.tar.bz2
fae3d2fda07684027a643ca783d595cc  xprop-1.2.2.tar.bz2
441fdb98d2abc6051108b7075d948fc7  xrandr-1.4.3.tar.bz2
b54c7e3e53b4f332d41ed435433fbda0  xrdb-1.1.0.tar.bz2
a896382bc53ef3e149eaf9b13bc81d42  xrefresh-1.0.5.tar.bz2
dcd227388b57487d543cab2fd7a602d7  xset-1.2.3.tar.bz2
7211b31ec70631829ebae9460999aa0b  xsetroot-1.1.1.tar.bz2
1fbd65e81323a8c0a4b5e24db0058405  xvinfo-1.1.2.tar.bz2
6b5d48464c5f366e91efd08b62b12d94  xwd-1.0.6.tar.bz2
b777bafb674555e48fd8437618270931  xwininfo-1.1.3.tar.bz2
3025b152b4f13fdffd0c46d0be587be6  xwud-1.0.4.tar.bz2
EOF

mkdir proto && cd proto
grep -v '^#' ../xorg-applications.md5 | awk '{print $2}' | wget -i- -c \
    -B http://xorg.freedesktop.org/releases/individual/app/
md5sum -c ../xorg-applications.md5

for package in $(grep -v '^#' ../xorg-applications.md5 | awk '{print $2}'); do
    packagedir=${package%.tar.bz2}
    tar -xf $package
    pushd $packagedir
        case $packagedir in
            luit-[0-9]*)
                line1="#ifdef _XOPEN_SOURCE"
                line2="#  undef _XOPEN_SOURCE"
                line3="#  define _XOPEN_SOURCE 600"
                line4="#endif"
                sed -i -e "s@#ifdef HAVE_CONFIG_H@$line1\n$line2\n$line3\n$line4\n\n&@" sys.c
                unset line1 line2 line3 line4
                ;;
        esac
        ./configure $XORG_CONFIG
        make && make install
    popd
    rm -rf $packagedir
done
