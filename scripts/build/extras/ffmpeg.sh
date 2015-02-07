VERSION=${VERSION-2.5.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "yasm" "libass" "libtheora" "libvorbis" "libvpx"

wget "http://ffmpeg.org/releases/ffmpeg-$VERSION.tar.bz2"
rm -rf ffmpeg-$VERSION && tar -jxf "ffmpeg-$VERSION.tar.bz2"
rm -f "ffmpeg-$VERSION.tar.bz2"
cd ffmpeg-$VERSION

./configure\
    --prefix=$PREFIX\
    --enable-gpl\
    --enable-version3\
    --enable-nonfree\
    --disable-static\
    --enable-shared\
    --disable-debug\
    --enable-libass\
    --enable-libfdk-aac\
    --enable-libmp3lame\
    --enable-libtheora\
    --enable-libvorbis\
    --enable-libvpx\
    --enable-libx264\
    --enable-x11grab\
    --docdir=$PREFIX/share/doc/ffmpeg-$VERSION

make && make install
