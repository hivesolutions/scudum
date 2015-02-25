VERSION=${VERSION-2.7.9}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "sqlite3" "pcre"

wget --no-check-certificate "https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tgz"
rm -rf Python-$VERSION && tar -zxf "Python-$VERSION.tgz"
rm -f "Python-$VERSION.tgz"
cd Python-$VERSION

if [ "$SCUDUM_CROSS" == "1" ]; then
    CC=gcc CFLAGS="" LDFLAGS="" LD_LIBRARY_PATH="" LIBRARY_PATH="" C_INCLUDE_PATH="" CPLUS_INCLUDE_PATH="" ./configure
    make python Parser/pgen
    mv python python_for_build
    mv Parser/pgen Parser/pgen_for_build

    ac_cv_file__dev_ptmx=no\
    ac_cv_file__dev_ptc=no\
    ac_cv_have_long_long_format=yes\
    ./configure --host=$ARCH_TARGET --build=x86_64 --prefix=$PREFIX --enable-shared --disable-ipv6
else
    ./configure --prefix=$PREFIX --enable-shared
fi

make && make install
