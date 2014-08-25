VERSION="7.3"
VERSION_L="73"
tar -jxf "vim-$VERSION.tar.bz2"
cd vim$VERSION_L

echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h

./configure --prefix=/usr --enable-multibyte
make
test $TEST && make test
make install

ln -sv vim /usr/bin/vi
for L in  /usr/share/man/{,*/}man1/vim.1; do
    ln -sv vim.1 $(dirname $L)/vi.1
done

ln -sv ../vim/vim$VERSION_L/doc /usr/share/doc/vim-$VERSION

cat > /etc/vimrc << "EOF"
set nocompatible
set backspace=2
syntax on
if (&term == "iterm") || (&term == "putty")
  set background=dark
endif

EOF

cd ..
rm -rf vim$VERSION_L
