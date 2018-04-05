################################################################################
#      This file is part of sx05re
#      no copyright, do as you please :)
################################################################################

PKG_NAME="sx05re_frontend"
PKG_VERSION=""
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="emulationstation"
PKG_SECTION="sx05re"
PKG_SHORTDESC="Sx05re Frontend Meta Package"
PKG_LONGDESC="Sx05re Frontend Meta Package"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  : not
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp $PKG_DIR/scripts/* $INSTALL/usr/bin
    chmod +x $INSTALL/usr/bin/*

  mkdir -p $INSTALL/usr/config/emulationstation
    cp $PKG_DIR/config/* $INSTALL/usr/config/emulationstation
  }
