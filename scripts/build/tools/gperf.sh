VERSION=${VERSION-3.0.4}

set -e +h

wget "http://ftp.gnu.org/pub/gnu/gperf/gperf-$VERSION.tar.gz"
rm -rf gperf-$VERSION && tar -zxf "gperf-$VERSION.tar.gz"
rm -f "gperf-$VERSION.tar.gz"
cd gperf-$VERSION

./configure --prefix=$PREFIX
make && make install
