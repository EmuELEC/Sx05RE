#!/bin/sh

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
