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
    cp -rp ../Python-$VERSION for_build
    cd for_build

    CC=gcc\
    RANLIB=ranlib\
    CFLAGS="-I/tools/include"\
    LDFLAGS="-L/tools/lib"\
    LD_LIBRARY_PATH="/tools/lib"\
    LIBRARY_PATH="/tools/lib"\
    C_INCLUDE_PATH="/tools/include" ./configure
    C_INCLUDE_PATH="/tools/include"\
    LD_LIBRARY_PATH="/tools/lib"\
    LIBRARY_PATH="/tools/lib" make python Parser/pgen sharedmods
    
    cd ..

    export PATH="for_build:$PATH"
    #cp -p python python_for_build
    cp -p for_build/Parser/pgen Parser/pgen_for_build
    #make distclean

    ac_cv_file__dev_ptmx=no\
    ac_cv_file__dev_ptc=no\
    ac_cv_have_long_long_format=yes\
    PYTHON_FOR_BUILD=for_build/python\
    ./configure --build=$SCUDUM_ARCH --host=$ARCH_TARGET --prefix=$PREFIX --enable-shared --disable-ipv6
else
    ./configure --prefix=$PREFIX --enable-shared
fi

make && make install
