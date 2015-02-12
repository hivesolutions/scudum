#!/bin/bash
# -*- coding: utf-8 -*-

EFI_NAME=${EFI_NAME-efiboot.img}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/base/config.sh

if type apt-get &> /dev/null; then
    apt-get -y install grub
elif type scu &> /dev/null; then
    env -u VERSION scu install grub.latest
else
    exit 1
fi

MOUNTPOINT=$(mktemp -d)

grub-mkimage\
    --format=x86_64-efi\
    --output=bootx64.efi\
    --config=$SCUDUM/boot/grub/grub.cfg\
    --compression=xz\
    --prefix=/EFI/BOOT\
    part_gpt part_msdos fat ext2 hfs hfsplus iso9660 udf ufs1 ufs2\
    zfs chain linux boot appleldr ahci configfile normal regexp\
    minicmd reboot halt search search_fs_file search_fs_uuid\
    search_label gfxterm gfxmenu efi_gop efi_uga all_video loadbios\
    gzio echo true probe loadenv bitmap_scale font cat help ls png\
    jpeg tga test at_keyboard usb_keyboard

dd if=/dev/zero of=$EFI_NAME bs=1K count=1440
mkdosfs -F 12 $EFI_NAME
mount -o loop $EFI_NAME $MOUNTPOINT

mkdir -pv $MOUNTPOINT/EFI/BOOT
cp -pv bootx64.efi $MOUNTPOINT/EFI/BOOT
rm -v bootx64.efi

umount $MOUNTPOINT && rmdir -rv $MOUNTPOINT
