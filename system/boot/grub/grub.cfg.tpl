set default=0
set timeout=5

insmod ${BOOT_FS}
set root=(hd0,1)

menuentry "Scudum GNU/Linux, Linux Stable" {
    linux /vmlinuz init=/linuxrc load_ramdisk=1 prompt_ramdisk=0 ramdisk_size=32768 root=/dev/ram rw video=vesafb:mtrr:3,ywrap vga=792 usb-storage.delay_use=0 quiet splash
}
