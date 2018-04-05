#!/bin/sh

hdmimode="1080p60hz"

# Most Emulators run best at 16bpp, Retroarch shaders works best and PPSSPPSDL ONLY runs at 16bpp
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

CFG="/storage/.emulationstation/es_settings.cfg"

PAT="s|\s*<string name=\"Sx05RE_$1_CORE\" value=\"\(.*\)\" />|\1|p"
EMU=$(sed -n "$PAT" "$CFG")

case $1 in
"MAME")
        if [ "$EMU" = "AdvanceMame" ]; then
        /usr/bin/advmame.sh "$2"
                else
        /usr/bin/retroarch -L /tmp/cores/${EMU}_libretro.so "$2"
        fi
        ;;
"PSP")
        if [ "$EMU" = "PPSSPPSA" ]; then
        /usr/bin/ppsspp.sh "$2"
                else
        /usr/bin/retroarch -L /tmp/cores/${EMU}_libretro.so "$2"
        fi
        ;;
*)
    /usr/bin/retroarch -L /tmp/cores/${EMU}_libretro.so "$2"
        ;;
esac

fbset -fb /dev/fb0 -g  $X $Y 1920 2160 $obpp
fbset -fb /dev/fb1 -g $obpp $obpp $obpp $obpp $obpp
echo 0 > /sys/class/graphics/fb0/free_scale
echo 0 > /sys/class/graphics/fb1/free_scale
echo 1 > /sys/class/video/disable_video
