set -e +h

if which apt-get 2> /dev/null; then
    apt-get -y install wget g++ make bison flex gawk gperf\
        texinfo libncurses5 libncurses5-dev libssl-dev
elif which scu 2> /dev/null; then
    echo "scudum: all dependencies already installed"
else
    echo "scudum: cannot install dependencies"
    exit 1
fi
