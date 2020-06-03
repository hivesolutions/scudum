VERSION=${VERSION-5.7.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "http://downloads.sourceforge.net/zsh/zsh-$VERSION.tar.xz?use_mirror=ayera"\
    "http://www.zsh.org/pub/old/zsh-$VERSION.tar.xz"
rm -rf zsh-$VERSION && tar -Jxf "zsh-$VERSION.tar.xz"
rm -f "zsh-$VERSION.tar.xz"
cd zsh-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX --with-tcsetpgrp
make && make install

cat > /root/.zshrc  << "EOF"
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\ee[C" forward-word
bindkey "\ee[D" backward-word
bindkey "^H" backward-delete-word
bindkey -s "^[Op" "0"
bindkey -s "^[Ol" "."
bindkey -s "^[OM" "^M"
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
bindkey -s "^[Ok" "+"
bindkey -s "^[Om" "-"
bindkey -s "^[Oj" "*"
bindkey -s "^[Oo" "/"
autoload -U compinit promptinit
compinit
promptinit
prompt walters
EOF

echo "$PREFIX/bin/zsh" >> /etc/shells

chsh -s "$PREFIX/bin/zsh"
