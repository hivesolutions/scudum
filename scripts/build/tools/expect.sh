VERSION=${VERSION-5.45.4}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "http://downloads.sourceforge.net/expect/expect$VERSION.tar.gz?use_mirror=netix"\
   "http://sources.buildroot.net/expect/expect$VERSION.tar.gz"
rm -rf expect$VERSION && tar -zxf "expect$VERSION.tar.gz"
rm -f "expect$VERSION.tar.gz"
cd expect$VERSION

cp -v configure{,.orig}
sed 's:/usr/local/bin:/bin:' configure.orig > configure

./configure\
    --prefix=$PREFIX\
    --with-tcl=$PREFIX/lib\
    --with-tclinclude=$PREFIX/include

make && make SCRIPTS="" install
