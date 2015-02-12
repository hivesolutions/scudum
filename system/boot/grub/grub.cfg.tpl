set default=0
set timeout=5

insmod loopback
insmod iso9660
insmod fat
insmod ntfs
insmod nftscomp

search --set=root --label SCUDUM
search --set=root --label Scudum

menuentry "Scudum GNU/Linux, Linux Stable" {
    linux /vmlinuz init=/linuxrc load_ramdisk=1 prompt_ramdisk=0 ramdisk_size=32768 root=/dev/ram rw video=vesafb:mtrr:3,ywrap vga=791 usb-storage.delay_use=0 quiet splash
}

menuentry "Scudum GNU/Linux, Linux Stable (Console)" {
    linux /vmlinuz init=/linuxrc load_ramdisk=1 prompt_ramdisk=0 ramdisk_size=32768 root=/dev/ram rw video=vesafb:mtrr:3,ywrap vga=791 usb-storage.delay_use=0 nomodeset
}

menuentry "Scudum GNU/Linux, Linux Stable (Vanilla)" {
    linux /vmlinuz init=/linuxrc load_ramdisk=1 prompt_ramdisk=0 ramdisk_size=32768 root=/dev/ram rw usb-storage.delay_use=0 nomodeset
}

menuentry "Scudum GNU/Linux, Linux Stable (Debug)" {
    linux /vmlinuz init=/linuxrc load_ramdisk=1 prompt_ramdisk=0 ramdisk_size=32768 root=/dev/ram rw usb-storage.delay_use=0 nomodeset initcall_debug loglevel=7
}

menuentry "Scudum GNU/Linux, Linux Stable (Debug Slow)" {
    linux /vmlinuz init=/linuxrc load_ramdisk=1 prompt_ramdisk=0 ramdisk_size=32768 root=/dev/ram rw usb-storage.delay_use=0 nomodeset initcall_debug loglevel=7 boot_delay=500
}
