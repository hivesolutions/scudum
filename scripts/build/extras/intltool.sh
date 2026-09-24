VERSION=${VERSION-0.51.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "xml-parser"

rget "https://mirrors.hive.pt/mirrors/scudum/intltool/$VERSION/intltool-$VERSION.tar.gz"\
    "https://launchpad.net/intltool/trunk/$VERSION/+download/intltool-$VERSION.tar.gz"
rm -rf intltool-$VERSION && tar -zxf "intltool-$VERSION.tar.gz"
rm -f "intltool-$VERSION.tar.gz"
cd intltool-$VERSION

# escapes the left braces that trigger a warning on every run with perl 5.22+
sed -i 's:\\\${:\\\$\\{:' intltool-update.in

./configure --prefix=$PREFIX
make && make install
