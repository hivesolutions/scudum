[ "$SCUDUM_CROSS" == "1" ] && exit 0 || true

VERSION=${VERSION-7.4}
VERSION_L=${VERSION_L-74}

set -e +h

wget --no-check-certificate "ftp://ftp.vim.org/pub/vim/unix/vim-$VERSION.tar.bz2"
rm -rf vim$VERSION_L && tar -jxf "vim-$VERSION.tar.bz2"
rm -f "vim-$VERSION.tar.bz2"
cd vim$VERSION_L

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
