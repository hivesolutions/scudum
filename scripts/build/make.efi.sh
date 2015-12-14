#!/bin/bash
# -*- coding: utf-8 -*-

EFI_NAME=${EFI_NAME-efiboot.img}
GRUB_EMBED=${GRUB_EMBED-boot/grub/grub.cfg.embed}

CUR=$(pwd)
DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/base/config.sh

if type apt-get &> /dev/null; then
    apt-get -y install grub-common dosfstools
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

grub-mkimage\
    --format=x86_64-efi\
    --output=bootx64.efi\
    --config=$SCUDUM/$GRUB_EMBED\
    --compression=$compression\
    --prefix=/EFI/BOOT\
    part_gpt part_msdos fat ext2 ntfs hfs hfsplus iso9660 udf ufs1 ufs2\
    zfs chain linux boot appleldr scsi ahci ehci configfile normal regexp\
    minicmd reboot halt search search_fs_file search_fs_uuid\
    search_label gfxterm gfxmenu efi_gop efi_uga all_video loadbios\
    gzio echo true probe loadenv bitmap_scale font cat help ls png\
    jpeg tga test at_keyboard usb_keyboard sleep usbms

dd if=/dev/zero of=$EFI_NAME bs=1K count=1440
mkdosfs -F 12 $EFI_NAME
mount -o loop $EFI_NAME $MOUNTPOINT

mkdir -pv $MOUNTPOINT/EFI/BOOT
cp -pv bootx64.efi $MOUNTPOINT/EFI/BOOT
rm -v bootx64.efi

umount $MOUNTPOINT && rm -rf $MOUNTPOINT
