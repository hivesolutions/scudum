[ "$SCUDUM_CROSS" == "1" ] && exit 0 || true

VERSION=${VERSION-9.2.1025}
VERSION_L=${VERSION_L-92}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/vim/$VERSION/vim-$VERSION.tar.gz"\
    "https://github.com/vim/vim/archive/v$VERSION/vim-$VERSION.tar.gz"
rm -rf vim-$VERSION && tar -zxf "vim-$VERSION.tar.gz"
rm -f "vim-$VERSION.tar.gz"
cd vim-$VERSION

echo "#define SYS_VIMRC_FILE \"/etc/vimrc\"" >> src/feature.h

./configure --host=$ARCH_TARGET --prefix=/usr

make
test $TEST && make test
make install

ln -svf vim /usr/bin/vi
for L in  /usr/share/man/{,*/}man1/vim.1; do
    ln -svf vim.1 $(dirname $L)/vi.1
done

ln -svf ../vim/vim$VERSION_L/doc /usr/share/doc/vim-$VERSION

cat > /etc/vimrc << "EOF"
set nocompatible
set backspace=2
syntax on
if (&term == "iterm") || (&term == "putty")
    set background=dark
endif

EOF
