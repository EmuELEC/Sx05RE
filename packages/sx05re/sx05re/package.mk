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
PKG_DEPENDS_TARGET="retroarch atari800 hatari uzebox tyrquake scummvm dosbox mgba prosystem o2em 81 fuse-libretro gw-libretro beetle-supergrafx genesis-plus-gx lutro gpsp ppsspp 2048 beetle-vb beetle-wswan beetle-ngp pcsx_rearmed vecx snes9x2010 dinothawr prboom beetle-pce handy picodrive nxengine nestopia gambatte stella fbalpha parallel-n64 mupen64plus beetle-pcfx mame2003 bluemsx fceumm"
PKG_SECTION="sx05re"
PKG_SHORTDESC="Sx05re Meta Package"
PKG_LONGDESC="Sx05re Meta Package"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET advancemame"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET PPSSPPSDL"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET vba-next"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET emulationstation"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libretro-beetle-pce-fast"
#PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET attract" 
#PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET jum52" 


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
