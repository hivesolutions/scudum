VERSION=${VERSION-5.4.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "zsh"

curl -L http://install.ohmyz.sh | sh
sed -i 's/ZSH_THEME=".*"/ZSH_THEME="pygmalion"/g' /root/.zshrc
sed -i 's/ == / = /g' /etc/environ

cat >> /root/.zshrc  << "EOF"
source /etc/profile.zsh
EOF

cat > /etc/profile.zsh  << "EOF"
source /etc/colors
source /config

source /etc/environ

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

for file in /etc/env/*.env; do
    source $file
done

alias "ls=ls --color=auto"
echo -e "Welcome to "$COLOR_GREEN"Scudum"$COLOR_RESET" $SVERSION (GNU/Linux $KVERSION)"
echo -e "System uptime: $UPTIME_S"

unset DISTRIB VERSION KVERSION SVERSION UPTIME UPTIME_SECS UPTIME_MINS UPTIME_HOURS UPTIME_DAYS UPTIME_S
EOF
