#!/bin/bash
# -*- coding: utf-8 -*-

EFI_NAME=${EFI_NAME-efiboot.img}
EFI_SIZE=${EFI_SIZE-4096}
GRUB_EMBED=${GRUB_EMBED-boot/grub/grub.cfg.embed}
GRUB_DIR=${GRUB_DIR-/usr/lib/grub/x86_64-efi}

CUR=$(pwd)
DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/base/config.sh

if type apt-get &> /dev/null; then
    apt-get -y install grub-common grub-efi-amd64-bin dosfstools
    compression=none
elif type scu &> /dev/null; then
    env -u VERSION scu install grub.latest dosfstools
    compression=xz
else
    exit 1
fi

if [ ! -e $SCUDUM/etc/scudum/CONFIGURED ]; then
    echo "make.efi: scudum not configured, not possible to make EFI"
    exit 1
fi

MOUNTPOINT=$(mktemp -d)

# filters the modules to the ones available in the installed grub
# version, as newer versions drop some of them (eg: efi_uga in 2.14),
# note that no native disk drivers (eg: ahci, ehci) are included as
# loading them stops the firmware disk access used to find the media
modules=""
for module in part_gpt part_msdos fat ext2 ntfs hfs hfsplus iso9660 udf ufs1 ufs2\
    zfs chain linux boot appleldr configfile normal regexp\
    minicmd reboot halt search search_fs_file search_fs_uuid\
    search_label gfxterm gfxmenu efi_gop efi_uga all_video loadbios\
    gzio echo true probe loadenv bitmap_scale font cat help ls png\
    jpeg tga test at_keyboard usb_keyboard sleep; do
    if [ -e $GRUB_DIR/$module.mod ]; then
        modules="$modules $module"
    else
        echo "make.efi: skipping '$module' module, not available in $GRUB_DIR"
    fi
done

grub-mkimage\
    --format=x86_64-efi\
    --output=bootx64.efi\
    --config=$SCUDUM/$GRUB_EMBED\
    --compression=$compression\
    --prefix=/EFI/BOOT\
    $modules

# the image size (in KB) leaves room for newer grub versions, the
# previous 1440K floppy size only has 18K free with GRUB 2.14
dd if=/dev/zero of=$EFI_NAME bs=1K count=$EFI_SIZE
mkdosfs -F 12 $EFI_NAME
mount -o loop $EFI_NAME $MOUNTPOINT

mkdir -pv $MOUNTPOINT/EFI/BOOT
cp -pv bootx64.efi $MOUNTPOINT/EFI/BOOT
rm -v bootx64.efi

umount $MOUNTPOINT && rm -rf $MOUNTPOINT
