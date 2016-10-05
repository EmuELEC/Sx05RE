#!/bin/sh

################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

[ -z "$SYSTEM_ROOT" ] && SYSTEM_ROOT=""
[ -z "$BOOT_ROOT" ] && BOOT_ROOT="/flash"
[ -z "$UPDATE_DIR" ] && UPDATE_DIR="/storage/.update"
DTB_UPDATE="$UPDATE_DIR/dtb.img"

for arg in $(cat /proc/cmdline); do
  case $arg in
    boot=*)
      boot="${arg#*=}"
      case $boot in
        /dev/mmc*)
          $SYSTEM_ROOT/usr/sbin/fatlabel $boot "BOOT"
          ;;
        LABEL=*)
          $SYSTEM_ROOT/usr/sbin/fatlabel $($SYSTEM_ROOT/sbin/findfs $boot) "BOOT"
          ;;
      esac

      if [ -f $DTB_UPDATE ] ; then
        case $boot in
          /dev/boot)
            dd if=$DTB_UPDATE of="/dev/dtb" bs=256k
            ;;
          /dev/mmc*|LABEL=*)
            mount -o rw,remount $BOOT_ROOT
            cp -f $DTB_UPDATE $BOOT_ROOT
            ;;
        esac
      fi
      ;;
    disk=*)
      disk="${arg#*=}"
      case $disk in
        /dev/mmc*)
          $SYSTEM_ROOT/sbin/e2label $disk "DISK"
          ;;
        LABEL=*)
          $SYSTEM_ROOT/sbin/e2label $($SYSTEM_ROOT/sbin/findfs $disk) "DISK"
          ;;
      esac
      ;;
  esac
done
