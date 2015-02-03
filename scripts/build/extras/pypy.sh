VERSION=${VERSION-2.4.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "python" "expat" "ffi"

wget "https://bitbucket.org/pypy/pypy/downloads/pypy-$VERSION-src.tar.bz2"
rm -rf pypy-$VERSION-src && tar -jxf "pypy-$VERSION-src.tar.bz2"
rm -f "pypy-$VERSION-src.tar.bz2"
cd pypy-$VERSION-src

cd pypy/goal
python ../../rpython/bin/rpython -Ojit targetpypystandalone
cd ../tool/release
python package.py --targetdir pypy-$VERSION.tar.bz2 --archive-name pypy --without-tk

mv pypy-$VERSION.tar.gz $PREFIX/lib
cd $PREFIX/lib

rm -rf pypy && tar -jxvf pypy-$VERSION.tar.bz2
rm -f pypy-$VERSION.tar.gz

ln -s ../lib/pypy/bin/pypy /usr/bin/pypy
