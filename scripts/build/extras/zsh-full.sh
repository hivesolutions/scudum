VERSION=${VERSION-5.4.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "zsh"

curl -L http://install.ohmyz.sh | sh
sed -i 's/ZSH_THEME=".*"/ZSH_THEME="pygmalion"/g' /root/.zshrc

rm -f /etc/environ.zsh && cp -p /etc/environ /etc/environ.zsh
sed -i 's/ == / = /g' /etc/environ.zsh

cat >> /root/.zshrc  << "EOF"
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
source /etc/profile.zsh
EOF

cat > /etc/profile.zsh  << "EOF"
source /etc/colors
source /config

source /etc/environ.zsh

DISTRIB=$(cat /etc/scudum/DISTRIB)
VERSION=$(cat /etc/scudum/VERSION)
KVERSION=$(uname -r)
SVERSION=$DISTRIB-$VERSION

UPTIME="$(/usr/bin/cut -d. -f1 /proc/uptime)"
UPTIME_SECS=$((${UPTIME}%60))
UPTIME_MINS=$((${UPTIME}/60%60))
UPTIME_HOURS=$((${UPTIME}/3600%24))
UPTIME_DAYS=$((${UPTIME}/86400))
UPTIME_S=$(printf "%d days, %02dh %02dm %02ds" "$UPTIME_DAYS" "$UPTIME_HOURS" "$UPTIME_MINS" "$UPTIME_SECS")
PROCESSES=$(ps ax | wc -l | tr -d " ")
IP4_ADDR=$(ip a | grep glo | awk '{print $2}' | head -1 | cut -f1 -d/)
IP6_ADDR=$(ip -6 a | grep glo | awk '{print $2}' | head -1 | cut -f1 -d/)

for file in /etc/env/*.env; do
    source $file
done

alias "ls=ls --color=auto"
echo -e "Welcome to "$COLOR_GREEN"Scudum"$COLOR_RESET" $SVERSION (GNU/Linux $KVERSION)"
echo -e ""
echo -e " * Running Processes:  $PROCESSES"
echo -e " * System uptime:      $UPTIME_S"
echo -e " * IP addresses:       $IP4_ADDR and $IP6_ADDR"
echo -e ""

unset DISTRIB VERSION KVERSION SVERSION UPTIME UPTIME_SECS UPTIME_MINS UPTIME_HOURS UPTIME_DAYS UPTIME_S PROCESSES IP4_ADDR IP6_ADDR
EOF
