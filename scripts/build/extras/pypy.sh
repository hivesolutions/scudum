VERSION=${VERSION-5.3.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "python" "expat" "libffi"

wget "https://bitbucket.org/pypy/pypy/downloads/pypy2-v$VERSION-src.tar.bz2"
rm -rf pypy2-v$VERSION-src && tar -jxf "pypy2-v$VERSION-src.tar.bz2"
rm -f "pypy2-v$VERSION-src.tar.bz2"
cd pypy2-v$VERSION-src

cd pypy/goal
python ../../rpython/bin/rpython -Ojit targetpypystandalone
cd ../tool/release
python package.py --targetdir pypy2-v$VERSION.tar.bz2 --archive-name pypy --without-tk || true

mv -v pypy2-v$VERSION.tar.bz2 $PREFIX/lib
cd $PREFIX/lib

rm -rvf pypy && tar -jxf pypy2-v$VERSION.tar.bz2
rm -vf pypy2-v$VERSION.tar.bz2

ln -sv ../lib/pypy/bin/pypy $PREFIX/bin/pypy
