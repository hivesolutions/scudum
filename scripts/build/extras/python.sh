VERSION=${VERSION-2.7.9}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "sqlite3" "pcre"

wget "https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tgz"
rm -rf Python-$VERSION && tar -zxf "Python-$VERSION.tgz"
rm -f "Python-$VERSION.tgz"
cd Python-$VERSION

if [ "$SCUDUM_CROSS" == "1" ]; then
    CC=gcc\
    RANLIB=ranlib\
    CFLAGS="-I/tools/include"\
    LDFLAGS="-L/tools/lib"\
    LD_LIBRARY_PATH="/tools/lib"\
    LIBRARY_PATH="/tools/lib"\
    C_INCLUDE_PATH="/tools/include" ./configure --prefix=/tools

    C_INCLUDE_PATH="/tools/include"\
    LD_LIBRARY_PATH="/tools/lib"\
    LIBRARY_PATH="/tools/lib" make && make install

    cp -p python python_for_build
    cp -p Parser/pgen Parser/pgen_for_build
    make distclean

    sed -i 's/$(PYTHON_FOR_BUILD) -Wi/$(HOSTPYTHON) -Wi/g' MAkefile.pre.in
    sed -i 's/$(PYTHON_FOR_BUILD) -m lib/$(HOSTPYTHON) -m lib/g' MAkefile.pre.in

    ac_cv_file__dev_ptmx=no\
    ac_cv_file__dev_ptc=no\
    ac_cv_have_long_long_format=yes\
    ./configure --build=$SCUDUM_HOST --host=$ARCH_TARGET --prefix=$PREFIX --enable-shared --disable-ipv6
    make HOSTPYTHON=/tools/bin/python && make HOSTPYTHON=/tools/bin/python install
else
    ./configure --prefix=$PREFIX --enable-shared
    make && make install
fi
