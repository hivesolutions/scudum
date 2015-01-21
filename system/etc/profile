source /etc/colors

export PATH="~/.local/bin:~/.local/sbin:/opt/bin:/opt/sbin:/pst/bin:/pst/sbin:$PATH"
export LD_LIBRARY_PATH="~/.local/lib:/opt/lib:/pst/lib:/usr/local/lib:/usr/lib:/lib"
export LIBRARY_PATH="~/.local/lib:/opt/lib:/pst/lib:/usr/local/lib:/usr/lib:/lib"
export C_INCLUDE_PATH="~/.local/include:/opt/include:/pst/include:/usr/local/include:/usr/include:/include"
export CPLUS_INCLUDE_PATH="~/.local/include:/opt/include:/pst/include:/usr/local/include:/usr/include:/include"
export MANPATH="~/.local/man:/opt/man:/opt/share/man:/pst/man:/pst/share/man:/usr/share/man:/usr/man:/usr/local/share/man"
export PKG_CONFIG_PATH="~/.local/lib/pkgconfig:~/.local/share/pkgconfig:/opt/lib/pkgconfig:/opt/share/pkgconfig:\
/pst/lib/pkgconfig:/pst/share/pkgconfig:/usr/local/lib/pkgconfig:/usr/local/share/pkgconfig:/usr/lib/pkgconfig:\
/usr/share/pkgconfig:/lib/pkgconfig:/share/pkgconfig"
export PERL5LIB="/opt/lib/perl5:/opt/lib/perl5/site_perl:/pst/lib/perl5:/pst/lib/perl5/site_perl"
export MAKEFLAGS="-j $(nproc)"
export LS_COLORS="ow=01;90:di=01;90"
export TERM=linux
export PS1="\u@\h:\w# "

if [ -e /etc/scudum/OVERLAYFS ]; then
    export PREFIX=/usr
else
    export PREFIX=/opt
fi

DISTRIB=$(cat /etc/scudum/DISTRIB)
VERSION=$(cat /etc/scudum/VERSION)
KVERSION=$(uname -r)
SVERSION=$DISTRIB-$VERSION

alias "ls=ls --color=auto"
echo -e "Welcome to "$COLOR_GREEN"Scudum"$COLOR_RESET" $SVERSION (GNU/Linux $KVERSION)"

unset DISTRIB VERSION KVERSION SVERSION
