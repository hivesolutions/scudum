VERSION=${VERSION-5.4.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "http://downloads.sourceforge.net/zsh/zsh-$VERSION.tar.gz"\
    "http://www.zsh.org/pub/old/zsh-$VERSION.tar.gz"
rm -rf zsh-$VERSION && tar -zxf "zsh-$VERSION.tar.gz"
rm -f "zsh-$VERSION.tar.gz"
cd zsh-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX
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
autoload -U compinit promptinit
compinit
promptinit
prompt walters
EOF

echo "$PREFIX/bin/zsh" >> /etc/shells
