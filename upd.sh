#!/bin/sh

cd /home/sg/sx05re/Lakka-LibreELEC
git pull
cp -urf /home/sg/sx05re/Lakka-LibreELEC/packages/libretro/* /home/sg/sx05re/no-ES/packages/sx05re/libretro/
sed -i -e 's/Odroid_C2|WeTek_Hub|WeTek_Play_2)/Odroid_C2|WeTek_Hub|WeTek_Play_2|S905)/g' /home/sg/sx05re/no-ES/packages/sx05re/libretro/mame2014/package.mk

cd /home/sg/sx05re/no-ES
make image PROJECT=S905 ARCH=arm DISTRO=Sx05RE -j8

