# retrieves the reference to the current files directory
# so that it's possible to "write" the scripts as relative
DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

# sets the abort on error flag so that if any of the
# commands fails the execution is stopped
set -e +h

# loads the currently defined configuration so that
# some of the required variables become available
source $DIR/config.sh

# runs the unmount operation for the complete set
# of devices associated with scudum (as expected)
mountpoint -q $SCUDUM/sys && umount -v $SCUDUM/sys
mountpoint -q $SCUDUM/proc && umount -v $SCUDUM/proc
mountpoint -q $SCUDUM/dev/shm && umount -v $SCUDUM/dev/shm
mountpoint -q $SCUDUM/dev/pts && umount -v $SCUDUM/dev/pts
mountpoint -q $SCUDUM/dev && umount -v $SCUDUM/dev

# runs the sync operation so that the unmounting is sure
# to be completed (avoiding possible removal errors)
sync

# creates the base directory where the scudum
# distribution will be installed for execution
# note that in case a persist location exits for
# it is used instead for the building process
if mountpoint -q $PERSIST; then
    rm -rf $PERSIST$SCUDUM
    rm -f $SCUDUM && ln -sv $PERSIST$SCUDUM $SCUDUM
else
    rm -rf $SCUDUM && mkdir -pv $SCUDUM
fi

# creates the proper tools directory where the
# build toolchain is going to be set and sets
# it as the root directory of the system
rm -rf $SCUDUM/tools && mkdir -pv $SCUDUM/tools
rm -rf /tools && ln -sv $SCUDUM/tools /
