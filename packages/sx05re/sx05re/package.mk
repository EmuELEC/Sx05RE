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
PKG_DEPENDS_TARGET="retroarch 2048 4do 81 atari800 beetle-ngp beetle-pce beetle-saturn beetle-supergrafx beetle-vb beetle-wswan bluemsx cap32 crocods desmume dinothawr dosbox fbalpha fceumm gambatte genesis-plus-gx gpsp gw-libretro handy hatari mame2003 mgba mrboom mupen64plus nestopia nxengine o2em parallel-n64 pcsx_rearmed pocketcdg prboom prosystem puae scummvm snes9x snes9x2002 snes9x2005 snes9x2010 stella tyrquake uzebox vbam vecx vice virtualjaguar xrick yabause"
PKG_SECTION="sx05re"
PKG_SHORTDESC="Sx05re Meta Package"
PKG_LONGDESC="Sx05re Meta Package"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET advancemame PPSSPPSDL vba-next emulationstation libretro-beetle-pce-fast"

#these packages do not compile on aarch64 yet.
if [ "$TARGET_ARCH" == "arm" ]; then
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET fuse-libretro lutro ppsspp beetle-pcfx picodrive"
fi


#PKG_DEPENDS_TARGET="retroarch atari800 hatari uzebox tyrquake scummvm dosbox mgba prosystem o2em 81 gw-libretro beetle-supergrafx genesis-plus-gx gpsp  2048 beetle-vb beetle-wswan beetle-ngp pcsx_rearmed vecx snes9x2010 dinothawr prboom beetle-pce handy  nxengine nestopia gambatte stella fbalpha mame2003 bluemsx fceumm"


#these packages are experimental, they do not compile at all yet.

#PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET attract" 
#PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET jum52"
#PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET reicastsa"




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
