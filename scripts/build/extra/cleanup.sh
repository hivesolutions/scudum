# sets the abort on error flag so that if any of the
# commands fails the execution is stopped
set -e

# runs the unmount operation for the complete set
# of devices associated with scudum (as expected)
mountpoint -q $SCUDUM/dev && umount $SCUDUM/dev
mountpoint -q $SCUDUM/dev/pts && umount $SCUDUM/dev/pts
mountpoint -q $SCUDUM/proc && umount $SCUDUM/proc
mountpoint -q $SCUDUM/sys && umount $SCUDUM/sys

# creates the base directory where the scudum
# distribution will be installed for execution
rm -rf $SCUDUM && mkdir -pv $SCUDUM

# creates the proper tools directory where the
# build toolchain is going to be set and sets
# it as the root directory of the system
rm -rf $SCUDUM/tools && mkdir -pv $SCUDUM/tools
rm -rf /tools && ln -sv $SCUDUM/tools /
