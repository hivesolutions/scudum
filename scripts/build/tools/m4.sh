VERSION=${VERSION-1.4.21}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "https://mirrors.hive.pt/mirrors/scudum/m4/$VERSION/m4-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/m4/m4-$VERSION.tar.xz"
rm -rf m4-$VERSION && tar -Jxf "m4-$VERSION.tar.xz"
rm -f "m4-$VERSION.tar.xz"
cd m4-$VERSION

cat > $SCUDUM/usr/share/config.site << EOF
ac_cv_func_posix_spawn_file_actions_addchdir=yes
ac_cv_func_posix_spawn_file_actions_addfchdir=yes
EOF

./configure\
    --prefix=/usr\
    --host=$SCUDUM_TARGET\
    --build=$(build-aux/config.guess)

make && make DESTDIR=$SCUDUM install
