set default=0
set timeout=5

insmod loopback
insmod iso9660
insmod fat
insmod ntfs
insmod nftscomp

menuentry "Scudum GNU/Linux, Linux Stable" {
    search --set=root --label SCUDUM
    linux /vmlinuz init=/linuxrc load_ramdisk=1 prompt_ramdisk=0 ramdisk_size=32768 root=/dev/ram rw video=vesafb:mtrr:3,ywrap vga=791 usb-storage.delay_use=0 quiet splash
}

menuentry "Scudum GNU/Linux, Linux Stable (Console)" {
    search --set=root --label SCUDUM
    linux /vmlinuz init=/linuxrc load_ramdisk=1 prompt_ramdisk=0 ramdisk_size=32768 root=/dev/ram rw video=vesafb:mtrr:3,ywrap vga=791 usb-storage.delay_use=0 nomodeset
}

menuentry "Scudum GNU/Linux, Linux Stable (Vanilla)" {
    search --set=root --label SCUDUM
    linux /vmlinuz init=/linuxrc load_ramdisk=1 prompt_ramdisk=0 ramdisk_size=32768 root=/dev/ram rw usb-storage.delay_use=0 nomodeset
}

menuentry "Scudum GNU/Linux, Linux Stable (Debug)" {
    search --set=root --label SCUDUM
    linux /vmlinuz init=/linuxrc load_ramdisk=1 prompt_ramdisk=0 ramdisk_size=32768 root=/dev/ram rw usb-storage.delay_use=0 nomodeset initcall_debug loglevel=7
}

menuentry "Scudum GNU/Linux, Linux Stable (Debug Slow)" {
    search --set=root --label SCUDUM
    linux /vmlinuz init=/linuxrc load_ramdisk=1 prompt_ramdisk=0 ramdisk_size=32768 root=/dev/ram rw usb-storage.delay_use=0 nomodeset initcall_debug loglevel=7 boot_delay=500
}
