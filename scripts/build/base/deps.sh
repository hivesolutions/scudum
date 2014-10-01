set -e +h

if type apt-get > /dev/null 2> &1; then
    apt-get -y install wget g++ make bison flex gawk gperf\
        texinfo libncurses5 libncurses5-dev libssl-dev
elif type scu > /dev/null 2> &1; then
    echo "scudum: dependencies already installed"
else
    echo "scudum: cannot install dependencies"
    exit 1
fi
