VERSION=${VERSION-2.6.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "python" "expat" "libffi"

wget "https://bitbucket.org/pypy/pypy/downloads/pypy-$VERSION-src.tar.bz2"
rm -rf pypy-$VERSION-src && tar -jxf "pypy-$VERSION-src.tar.bz2"
rm -f "pypy-$VERSION-src.tar.bz2"
cd pypy-$VERSION-src

cd pypy/goal
python ../../rpython/bin/rpython -Ojit targetpypystandalone
cd ../tool/release
python package.py --targetdir pypy-$VERSION.tar.bz2 --archive-name pypy --without-tk || true

mv -v pypy-$VERSION.tar.bz2 $PREFIX/lib
cd $PREFIX/lib

rm -rvf pypy && tar -jxf pypy-$VERSION.tar.bz2
rm -vf pypy-$VERSION.tar.bz2

ln -sv ../lib/pypy/bin/pypy $PREFIX/bin/pypy
