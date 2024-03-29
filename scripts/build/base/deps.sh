set -e +h

if type apt-get &> /dev/null; then
    echo "scudum: apt-get dependencies"
    apt-get -y install wget g++ make bison flex gawk gperf cpio\
        gzip bzip2 xz-utils patch texinfo python3 libncurses5\
        libncurses5-dev libssl-dev
elif type scu &> /dev/null; then
    echo "scudum: dependencies already installed"
else
    echo "scudum: cannot install dependencies"
    exit 1
fi
