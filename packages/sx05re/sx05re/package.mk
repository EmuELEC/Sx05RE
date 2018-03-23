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
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET vba-next libretro-beetle-pce-fast advancemame PPSSPPSDL emulationstation reicastsa common-shaders scraper"

 
# You can build some less used Libretro cores by using $LIBRETRO_EXTRA_CORES but you might run into size problems.
#PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $LIBRETRO_EXTRA_CORES mame2010 mame2014"


# Pegasus-FE works, but it is still in very early stage, if you enable make sure you have enough space on the partition.
#PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET pegasus-frontend"


# These packages are experimental, they do not compile or have other problems, any help getting these to work is highly appreciated!.
#PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET attract" 



make_target() {
  : not
}

makeinstall_target() {
   
  mkdir -p $INSTALL/etc/samba
   cp $PKG_DIR/config/smb.conf $INSTALL/etc/samba

  mkdir -p $INSTALL/usr/config/
    cp -rf $PKG_DIR/config/* $INSTALL/usr/config/
    cp $PKG_DIR/autostart.sh $INSTALL/usr/config/autostart.sh
 
  mkdir -p $INSTALL/usr/bin/
    cp $PKG_DIR/bin/* $INSTALL/usr/bin/
    chmod +x $INSTALL/usr/bin/*

  mkdir -p $INSTALL/usr/share/kodi/addons/
    cp -rf $PKG_DIR/addon/* $INSTALL/usr/share/kodi/addons/

  mkdir -p $INSTALL/usr/share/retroarch-overlays
    cp -r $PKG_DIR/overlay/* $INSTALL/usr/share/retroarch-overlays
  
  mkdir -p $INSTALL/usr/share/common-shaders
    cp -r $PKG_DIR/shaders/* $INSTALL/usr/share/common-shaders
    
    mkdir -p $INSTALL/usr/share/libretro-database
     touch $INSTALL/usr/share/libretro-database/dummy

##this needs to be moved to filesystem, but I put it here for easy testing. 
  mkdir -p $INSTALL/usr/config/asound.conf
    cp $PKG_DIR/asound.conf/asound.conf $INSTALL/usr/config/asound.conf/asound.conf

}
