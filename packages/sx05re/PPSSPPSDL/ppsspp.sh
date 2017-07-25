#!/bin/sh

hdmimode="1080p60hz"


#PPSSPP unfortunately only runs at 16bpp 
bpp="16"

obpp="32"

# Set framebuffer geometry to match the resolution 
case $hdmimode in
  480*)            X=720  Y=480  ;;
  576*)            X=720  Y=576  ;;
  720p*)           X=1280 Y=720  ;;
  *)               X=1920 Y=1080 ;;
esac

fbset -fb /dev/fb0 -g  $X $Y 1920 2160 $bpp
fbset -fb /dev/fb1 -g $bpp $bpp $bpp $bpp $bpp
echo 0 > /sys/class/graphics/fb0/free_scale
echo 0 > /sys/class/graphics/fb1/free_scale
echo 1 > /sys/class/video/disable_video

ARG=${1//[\\]/}
         
SDL_AUDIODRIVER=alsa PPSSPPSDL "$ARG" > /dev/null 2>&1

while pgrep PPSSPP > /dev/null; do sleep 1; done

fbset -fb /dev/fb0 -g  $X $Y 1920 2160 $obpp
fbset -fb /dev/fb1 -g $obpp $obpp $obpp $obpp $obpp
echo 0 > /sys/class/graphics/fb0/free_scale
echo 0 > /sys/class/graphics/fb1/free_scale
echo 1 > /sys/class/video/disable_video
