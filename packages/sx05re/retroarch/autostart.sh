#!/bin/sh

# USB roms 

sleep 2

#name of the file we need to put in the roms folder
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
./usr/lib/samba/samba-config
systemctl start smbd

rm -r /var/lock/start.kodi
touch /var/lock/start.games
systemctl start emustation.service


