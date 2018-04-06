#!/bin/sh

hdmimode=`cat /sys/class/display/mode`;

# Most Emulators run best at 16bpp, Retroarch shaders works best and PPSSPPSDL ONLY runs at 16bpp
bpp="16"
obpp="32"

# Set framebuffer geometry to match the resolution 
case $hdmimode in
  480*)            X=720  Y=480  SPLASH="/storage/.config/splash/splash-1080.png" ;;
  576*)            X=720  Y=576  SPLASH="/storage/.config/splash/splash-1080.png" ;;
  720p*)           X=1280 Y=720  SPLASH="/storage/.config/splash/splash-1080.png" ;;
  *)               X=1920 Y=1080 SPLASH="/storage/.config/splash/splash-1080.png" ;;
esac

fbset -fb /dev/fb0 -g  $X $Y 1920 2160 $bpp

# loading screen, not sure if this is the best way to do it, but it works so far. 
(
   (cmdpid=$BASHPID; (sleep 10; kill $cmdpid) & exec fbi $SPLASH -noverbose > /dev/null 2>&1)
)&

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
