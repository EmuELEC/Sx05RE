#!/bin/sh

case $1 in
"KODI")
rm -rf /storage/.kodi*
systemctl reboot
  ;;
"EMUS")
rm -rf /storage/.emulationstation*
rm -rf /storage/.local*
rm -rf /storage/.config/emulationstation*
rm -rf /storage/.config/ppsspp*
rm -rf /storage/.config/reicast*
rm -rf /storage/.config/retroarch*
rm -rf /storage/.advance*
systemctl reboot
  ;;
"ALL")
rm -rf /storage/.*
systemctl reboot
  ;;
esac
