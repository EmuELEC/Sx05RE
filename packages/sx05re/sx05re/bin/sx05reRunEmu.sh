#!/bin/sh

hdmimode=`cat /sys/class/display/mode`;

# Set framebuffer geometry to match the resolution 
case $hdmimode in
  480*)            X=720  Y=480  SPLASH="/storage/.config/splash/splash-1080.png" ;;
  576*)            X=720  Y=576  SPLASH="/storage/.config/splash/splash-1080.png" ;;
  720p*)           X=1280 Y=720  SPLASH="/storage/.config/splash/splash-1080.png" ;;
  *)               X=1920 Y=1080 SPLASH="/storage/.config/splash/splash-1080.png" ;;
esac

# Most Emulators work best at 16bpp, Retroarch shaders work best and PPSSPPSDL ONLY runs at 16bpp
fbset -fb /dev/fb0 -g  $X $Y 1920 2160 16

# splash screen, not sure if this is the best way to do it, but it works so far, but not as good as I want it too with PPSSPPSDL and advmame :(  
(
  fbi $SPLASH -noverbose > /dev/null 2>&1
)&

CFG="/storage/.emulationstation/es_settings.cfg"

PAT="s|\s*<string name=\"Sx05RE_$1_CORE\" value=\"\(.*\)\" />|\1|p"
EMU=$(sed -n "$PAT" "$CFG")

case $1 in
"MAME")
        if [ "$EMU" = "AdvanceMame" ]; then
   # advmame runs best at 32bpp     
   fbset -fb /dev/fb0 -g  $X $Y 1920 2160 32
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

# Return to 32bit mode
fbset -fb /dev/fb0 -g  $X $Y 1920 2160 32
