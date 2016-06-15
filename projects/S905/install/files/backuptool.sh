#!/sbin/sh

case "$1" in
  backup)
    if [ -a /dev/dtb ]; then
      busybox dd if=/dev/dtb | busybox gzip > /tmp/dtb.img.gz
    fi
    busybox mount -o ro /dev/block/system /system
    if [ -f /system/remote.conf ]; then
      busybox cp /system/remote.conf /tmp/remote.conf
    elif [ -f /system/etc/remote.conf ]; then
      busybox cp -PR /system/etc/remote.conf /tmp/remote.conf
    fi
    busybox umount /system
    ;;

  restore)
    busybox mount -o rw /dev/block/system /system
    if [ -f /tmp/dtb.img.gz ]; then
      busybox cp -PR /tmp/dtb.img.gz /system/dtb.img.gz
    fi
    if [ -f /tmp/remote.conf ]; then
      busybox cp -PR /tmp/remote.conf /system/remote.conf
    fi
    busybox umount /system
    ;;
esac
