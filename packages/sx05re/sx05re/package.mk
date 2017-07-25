################################################################################
#      This file is part of sx05re
#      no copyright, do as you please :)
################################################################################

PKG_NAME="sx05re"
PKG_VERSION=""
PKG_REV="1"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPLv3"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="retroarch-sx05re $LIBRETRO_CORES"
PKG_SECTION="sx05re"
PKG_SHORTDESC="Sx05re Meta Package"
PKG_LONGDESC="Sx05re Meta Package"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

# Thanks to magicseb  Reicast SA now WORKS :D
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET mame2010 mame2014 vba-next libretro-beetle-pce-fast advancemame PPSSPPSDL emulationstation fbida reicastsa"

# You can build some less used Libretro cores by using $LIBRETRO_EXTRA_CORES but you might run into size problems.
#PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $LIBRETRO_EXTRA_CORES"


# Pegasus-FE works, but it is still in very early stage, if you enable make sure you have enought space on the partition.
#PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET pegasus-frontend"


# These packages are experimental, they do not compile or have other problems, any help getting these to work is highly appreciated!.

#PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET attract" 
#PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET jum52"
#PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET hurrican"


make_target() {
  : not
}

makeinstall_target() {

  mkdir -p $INSTALL/usr/config/
    cp -rf $PKG_DIR/config/* $INSTALL/usr/config/
    cp $PKG_DIR/autostart.sh $INSTALL/usr/config/autostart.sh
 
mkdir -p $INSTALL/usr/bin/
    cp $PKG_DIR/bin/* $INSTALL/usr/bin/

mkdir -p $INSTALL/usr/share/kodi/addons/
    cp -rf $PKG_DIR/addon/* $INSTALL/usr/share/kodi/addons/


##this needs to be moved to filesystem, but put it here for easy testing. 
#mkdir -p $INSTALL/usr/config/asound.conf
#cp $PKG_DIR/asound.conf/asound.conf $INSTALL/usr/config/asound.conf/asound.conf

}
