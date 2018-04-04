#!/bin/sh
# USB roms 
sleep 2

# Clean cache garbage when boot up.
rm -rf /storage/.cache/cores/*

# Read the video output mode and set it for sx05re to avoid video flicking.
MODE=`cat /sys/class/display/mode`;

case "$MODE" in
"480p60hz")
	fbset -fb /dev/fb0 -g 720 480 720 960 32
	;;
"576p50hz")
	fbset -fb /dev/fb0 -g 720 576 720 1152 32
	;;
"720p60hz")
	fbset -fb /dev/fb0 -g 1280 720 1280 1440 32
	;;
"720p50hz")
	echo 720p60hz > /sys/class/display/mode
	fbset -fb /dev/fb0 -g 1280 720 1280 1440 32
	;;
"1080p60hz")
	fbset -fb /dev/fb0 -g 1920 1080 1920 2160 32
	;;
"1080i60hz")
	fbset -fb /dev/fb0 -g 1920 1080 1920 2160 32
	;;
"1080i50hz")
	echo 1080i60hz > /sys/class/display/mode
	fbset -fb /dev/fb0 -g 1920 1080 1920 2160 32
	;;
"1080p50hz")
	echo 1080p60hz > /sys/class/display/mode
	fbset -fb /dev/fb0 -g 1920 1080 1920 2160 32
	;;
"480cvbs")
	fbset -fb /dev/fb0 -g 1280 960 1280 1920 32
	fbset -fb /dev/fb1 -g 32 32 32 32 32
	echo 0 0 1279 959 > /sys/class/graphics/fb0/free_scale_axis
	echo 30 10 669 469 > /sys/class/graphics/fb0/window_axis
	echo 640 > /sys/class/graphics/fb0/scale_width
	echo 480 > /sys/class/graphics/fb0/scale_height
	echo 0x10001 > /sys/class/graphics/fb0/free_scale
	;;
"576cvbs")
	fbset -fb /dev/fb0 -g 1280 960 1280 1920 32
	fbset -fb /dev/fb1 -g 32 32 32 32 32
	echo 0 0 1279 959 > /sys/class/graphics/fb0/free_scale_axis
	echo 35 20 680 565 > /sys/class/graphics/fb0/window_axis
	echo 720 > /sys/class/graphics/fb0/scale_width
	echo 576 > /sys/class/graphics/fb0/scale_height
	echo 0x10001 > /sys/class/graphics/fb0/free_scale
	;;
esac

# End of reading the video output mode and setting it for sx05re to avoid video flicking.
# The codes can be simplified with "elseif" sentences.
# The codes for 480I and 576I are adjusted to avoid overscan.
# Forece 720p50hz to 720p60hz and 1080i/p60hz to 1080i/p60hz since 50hz would make video very choppy.

#since the ROMS folder is not getting created at boot, we check if it exists, if it doesn't then we create it. 
if [ ! -d "/storage/roms" ] || [ ! -d "/storage/roms2" ]; then
  mkdir /storage/roms
  
all_roms="atari2600,atari5200,atari7800,atarilynx,c64,dreamcast,fba,fds,gamegear,gb,gba,gbc,mame,mame-advmame,mastersystem,megadrive,msx,n64,neogeo,nes,pc,pcengine,psp,psx,scummvm,sega32x,segacd,snes,videopac,zxspectrum" 

for romfolder in $(echo $all_roms | tr "," " "); do
  mkdir -p /storage/roms/$romfolder
done
  
fi

#name of the file we need to put in the roms folder in your USB or SDCARD 
ROMFILE="sx05reroms"

# we look for the file in the rompath
FULLPATHTOROMS="$(find /media/*/roms/ -name $ROMFILE -maxdepth 1)"

if [[ -z "${FULLPATHTOROMS}" ]]; then
# echo "can't find roms"

    if [ -L /storage/roms ]; then
      rm /storage/roms
      mv /storage/roms2 /storage/roms
 fi
    else
      mv /storage/roms /storage/roms2
      #echo "move the roms folder"
 
       # we strip the name of the file.
       PATHTOROMS=${FULLPATHTOROMS%$ROMFILE}

       #we create the symlink to the roms in our USB
       ln -sf $PATHTOROMS /storage/roms
 fi

#set reicast BIOS dir to point to /storage/roms/bios
if [ ! -L /storage/.local/share/reicast/data ]; then
	mkdir -p /storage/.local/share/reicast 
	rm -rf /storage/.local/share/reicast/data
	ln -s /storage/roms/bios /storage/.local/share/reicast/data
fi

#hacky way to get samba on boot
/usr/lib/samba/samba-config
systemctl start smbd

if [ ! -f /storage/.emulationstation/es_settings.cfg ]; then
   cp /usr/config/emulationstation/es_settings.cfg /storage/.emulationstation/es_settings.cfg
fi

DEFE=$(sed -n 's|\s*<string name="Sx05RE_BOOT" value="\(.*\)" />|\1|p' /storage/.emulationstation/es_settings.cfg)

case "$DEFE" in
"Kodi")
	rm -rf /var/lock/start.retro
	rm -rf /var/lock/start.games
	touch  /var/lock/start.kodi
	;;
"Retroarch")
	rm -rf /var/lock/start.kodi
	rm -rf /var/lock/start.games
	touch /var/lock/start.retro
	systemctl start retroarch
	;;
*)
	rm -rf /var/lock/start.kodi
	rm -rf /var/lock/start.retro
	/usr/bin/startfe.sh &
	;;
esac
