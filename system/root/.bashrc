source /etc/colors

export PATH="~/.local/bin:~/.local/sbin:/opt/bin:/opt/sbin:/pst/bin:/pst/sbin:$PATH"
export LD_LIBRARY_PATH="~/.local/lib:/opt/lib:/pst/lib:/usr/local/lib:/usr/lib:/lib"
export LIBRARY_PATH="~/.local/lib:/opt/lib:/pst/lib:/usr/local/lib:/usr/lib:/lib"
export C_INCLUDE_PATH="~/.local/include:/opt/include:/pst/include:/usr/local/include:/usr/include:/include"
export CPLUS_INCLUDE_PATH="~/.local/include:/opt/include:/pst/include:/usr/local/include:/usr/include:/include"
export MANPATH="~/.local/man:/opt/man:/opt/share/man:/pst/man:/pst/share/man:/usr/share/man:/usr/man:/usr/local/share/man"
export LS_COLORS="ow=01;90:di=01;90"
export TERM=linux
export GREP_OPTIONS=--color=auto
export PREFIX=/opt

VERSION=$(cat /etc/scudum/VERSION)
KVERSION=$(uname -r)
SVERSION=alpha-$VERSION
PS1="\u@\h:\w# "

alias "ls=ls --color=auto"
echo -e "Welcome to "$COLOR_GREEN"Scudum"$COLOR_RESET" $SVERSION (GNU/Linux $KVERSION)"
