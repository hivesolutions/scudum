VERSION=${VERSION-3.0.4}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/gperf/gperf-$VERSION.tar.gz"
rm -rf gperf-$VERSION && tar -zxf "gperf-$VERSION.tar.gz"
rm -f "gperf-$VERSION.tar.gz"
cd gperf-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr --docdir=/usr/share/doc/gperf-3.0.4

make && make install
