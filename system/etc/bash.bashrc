source /etc/colors

export PATH="~/.local/bin:~/.local/sbin:/opt/bin:/opt/sbin:/scd/bin:/scd/sbin:$PATH"
export LD_LIBRARY_PATH="~/.local/lib:/opt/lib:/scd/lib:/usr/local/lib:/usr/lib:/lib"
export LIBRARY_PATH="~/.local/lib:/opt/lib:/scd/lib:/usr/local/lib:/usr/lib:/lib"
export C_INCLUDE_PATH="~/.local/include:/opt/include:/scd/include:/usr/local/include:/usr/include:/include"
export CPLUS_INCLUDE_PATH="~/.local/include:/opt/include:/scd/include:/usr/local/include:/usr/include:/include"
export LS_COLORS="ow=01;90:di=01;90"
export TERM=linux
export GREP_OPTIONS=--color=auto
export PREFIX=/opt

VERSION=$(cat /etc/scudum/VERSION)
KVERSION=$(uname -r)
SVERSION=alpha-$VERSION
PS1="\u@\h:\w# "
