set -e +h

if hash apt-get 2> /dev/null; then
    apt-get -y install wget g++ make bison flex gawk gperf\
        texinfo libncurses5 libncurses5-dev libssl-dev
elif hash scu 2> /dev/null; then
    continue
else
    exit 1
fi
