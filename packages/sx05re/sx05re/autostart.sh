#!/bin/sh
# USB roms 
sleep 2

# Clean cache garbage when boot up.
rm -rf /storage/.cache/cores/*

# Read the video output mode and set it for sx05re to avoid video flicking.
MODE=`cat /sys/class/display/mode`;
if [ "$MODE" = "480p60hz" ]; then
fbset -fb /dev/fb0 -g 720 480 720 960 32
fi

MODE=`cat /sys/class/display/mode`;
if [ "$MODE" = "576p50hz" ]; then
fbset -fb /dev/fb0 -g 720 576 720 1152 32
fi

MODE=`cat /sys/class/display/mode`;
if [ "$MODE" = "720p60hz" ]; then
fbset -fb /dev/fb0 -g 1280 720 1280 1440 32
fi

MODE=`cat /sys/class/display/mode`;
if [ "$MODE" = "720p50hz" ]; then
fbset -fb /dev/fb0 -g 1280 720 1280 1440 32
fi

MODE=`cat /sys/class/display/mode`;
if [ "$MODE" = "1080p60hz" ]; then
fbset -fb /dev/fb0 -g 1920 1080 1920 2160 32
fi

MODE=`cat /sys/class/display/mode`;
if [ "$MODE" = "1080i60hz" ]; then
fbset -fb /dev/fb0 -g 1920 1080 1920 2160 32
fi

MODE=`cat /sys/class/display/mode`;
if [ "$MODE" = "1080i50hz" ]; then
fbset -fb /dev/fb0 -g 1920 1080 1920 2160 32
fi

MODE=`cat /sys/class/display/mode`;
if [ "$MODE" = "1080p50hz" ]; then
fbset -fb /dev/fb0 -g 1920 1080 1920 2160 32
fi

MODE=`cat /sys/class/display/mode`;
if [ "$MODE" = "480cvbs" ]; then
fbset -fb /dev/fb0 -g 1280 960 1280 1920 32
fbset -fb /dev/fb1 -g 32 32 32 32 32
echo 0 0 1279 959 > /sys/class/graphics/fb0/free_scale_axis
echo 30 10 669 469 > /sys/class/graphics/fb0/window_axis
echo 640 > /sys/class/graphics/fb0/scale_width
echo 480 > /sys/class/graphics/fb0/scale_height
echo 0x10001 > /sys/class/graphics/fb0/free_scale
fi

MODE=`cat /sys/class/display/mode`;
if [ "$MODE" = "576cvbs" ]; then
fbset -fb /dev/fb0 -g 1280 960 1280 1920 32
fbset -fb /dev/fb1 -g 32 32 32 32 32
echo 0 0 1279 959 > /sys/class/graphics/fb0/free_scale_axis
echo 35 20 680 565 > /sys/class/graphics/fb0/window_axis
echo 720 > /sys/class/graphics/fb0/scale_width
echo 576 > /sys/class/graphics/fb0/scale_height
echo 0x10001 > /sys/class/graphics/fb0/free_scale
fi
# End of reading the video output mode and setting it for sx05re to avoid video flicking.
# The codes can be simplified with "elseif" sentences.
# The codes for 480I and 576I are adjusted to avoid overscan.

#since the ROMS folder is not getting created at boot, we check if it exists, if it doesn't then we create it. 
if [ ! -d "/storage/roms" ] || [ ! -d "/storage/roms2" ]; then
  mkdir /storage/roms
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

# THESE CHANGES ARE UNSTESTED! I DONT KNOW IF YOUR DEVICE WILL EXPLODE UNCOMMENT UNDER YOUR OWN RISK!

# Set the device to run at top speed all the time, it has made a lot of emulators run better when all of them are set.
# Make sure you have cooling other than the default.

# Echoing 5 will get you 792MHz for S905 and 742MHz for S905X
#echo 5 > /sys/class/mpgpu/cur_freq
#echo 5 > /sys/class/mpgpu/max_freq
#echo 5 > /sys/class/mpgpu/min_freq

##set CPU max
#echo 1536000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
#echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

#make sure the requirement to run kodi is met.
touch  /var/lock/start.kodi

 #if you don't want EmulationStation to start first, comment the next 3 lines
 rm -rf /var/lock/start.kodi
 touch /var/lock/start.games
 systemctl start emustation
