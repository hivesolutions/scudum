VERSION=${VERSION-2.4.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "expat" "libffi" "libtinfo"

wget "https://bitbucket.org/pypy/pypy/downloads/pypy-$VERSION-linux64.tar.bz2"
rm -rf pypy-$VERSION-linux64 && tar -jxf "pypy-$VERSION-linux64.tar.bz2"

mv -v pypy-$VERSION-linux64.tar.bz2 $PREFIX/lib
cd $PREFIX/lib

rm -rvf pypy && tar -jxf pypy-$VERSION-linux64.tar.bz2
mv pypy-$VERSION-linux64 pypy
rm -vf pypy-$VERSION-linux64.tar.bz2

ln -sv ../lib/pypy/bin/pypy $PREFIX/bin/pypy
