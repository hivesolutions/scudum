# sets the abort on error flag so that if any of the
# commands fails the execution is stopped
set -e

# runs the unmount operation for the complete set
# of devices associated with scudum (as expected)
if mountpoint -q $SCUDUM/dev; then
    umount $SCUDUM/dev
fi
if mountpoint -q $SCUDUM/dev/pts; then
    umount $SCUDUM/dev/pts
fi
if mountpoint -q $SCUDUM/proc; then
    umount $SCUDUM/proc
fi
if mountpoint -q $SCUDUM/sys; then
    umount $SCUDUM/sys
fi

# creates the base directory where the scudum
# distribution will be installed for execution
rm -rf $SCUDUM
mkdir -pv $SCUDUM

# creates the proper tools directory where the
# build toolchain is going to be set and sets
# it as the root directory of the system
rm -rf $SCUDUM/tools
rm -rf /tools
mkdir -pv $SCUDUM/tools
ln -sv $SCUDUM/tools /
