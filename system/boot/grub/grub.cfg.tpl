set default=0
set timeout=5

insmod ${BOOT_FS}
set root=(hd0,1)

menuentry "GNU/Linux, Linux Stable" {
    linux /vmlinuz root=/dev/sda3 ro video=vesafb:mtrr:3,ywrap vga=791 usb-storage.delay_use=0
}
