#!/bin/sh
# USB roms 
sleep 2

#name of the file we need to put in the roms folder in your USB or SDCARD 
ROMFILE="sx05reroms"


# we look for the file in the rompath
FULLPATHTOROMS="$(find /media/*/roms/ -name $ROMFILE -maxdepth 1)"
#echo "${FULLPATHTOROMS}"


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


 #if you don't want EmulationStation to start first, comment the next 3 lines
 #rm -rf /var/lock/start.kodi
 #touch /var/lock/start.games
 #systemctl start emustation