VERSION=${VERSION-5.3.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "expat" "libffi" "libtinfo"

wget "https://bitbucket.org/pypy/pypy/downloads/pypy2-v$VERSION-linux64.tar.bz2"
rm -rf pypy2-v$VERSION-linux64 && tar -jxf "pypy2-v$VERSION-linux64.tar.bz2"

mv -v pypy2-v$VERSION-linux64.tar.bz2 $PREFIX/lib
cd $PREFIX/lib

rm -rvf pypy && tar -jxf pypy2-v$VERSION-linux64.tar.bz2
mv pypy2-v$VERSION-linux64 pypy
rm -vf pypy2-v$VERSION-linux64.tar.bz2

ln -sv ../lib/pypy/bin/pypy $PREFIX/bin/pypy
