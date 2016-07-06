VERSION=${VERSION-5.2.0-alpha1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "expat" "libffi" "libtinfo"

wget "https://bitbucket.org/pypy/pypy/downloads/pypy3.3-v$VERSION-linux64.tar.bz2"
rm -rf pypy3.3-v$VERSION-linux64 && tar -jxf "pypy3.3-v$VERSION-linux64.tar.bz2"

mv -v pypy3.3-v$VERSION-linux64.tar.bz2 $PREFIX/lib
cd $PREFIX/lib

rm -rvf pypy3.3 && tar -jxf pypy3.3-v$VERSION-linux64.tar.bz2
mv pypy3.3-v$VERSION-linux64 pypy3.3
rm -vf pypy3.3-v$VERSION-linux64.tar.bz2

ln -svf ../lib/pypy3.3/bin/pypy3.3 $PREFIX/bin/pypy3
