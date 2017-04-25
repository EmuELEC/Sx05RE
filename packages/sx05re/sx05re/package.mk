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
PKG_DEPENDS_TARGET="retroarch-sx05re 2048 4do 81 atari800 beetle-lynx beetle-ngp beetle-pce beetle-saturn beetle-supergrafx beetle-vb beetle-wswan bluemsx cap32 crocods desmume dinothawr dosbox easyrpg fbalpha fceumm gambatte genesis-plus-gx gpsp gw-libretro handy hatari mame2003 mgba mrboom mupen64plus nestopia nxengine o2em parallel-n64 pcsx_rearmed pocketcdg prboom prosystem puae scummvm snes9x snes9x2002 snes9x2005 snes9x2010 stella tyrquake uae4arm uzebox vbam vecx vice virtualjaguar xrick yabause mame2014"
PKG_SECTION="sx05re"
PKG_SHORTDESC="Sx05re Meta Package"
PKG_LONGDESC="Sx05re Meta Package"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"


#these packages do not compile on aarch64 yet.
if [ "$TARGET_ARCH" == "arm" ]; then
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET fuse-libretro lutro ppsspp beetle-pcfx picodrive"
fi

PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET vba-next libretro-beetle-pce-fast advancemame PPSSPPSDL emulationstation"

#these packages are experimental, they do not compile or have other problems, any help getting these to work is highly appreciated!.

#PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET attract" 
#PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET jum52"
#PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET reicastsa"
#PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET sameboy"
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
