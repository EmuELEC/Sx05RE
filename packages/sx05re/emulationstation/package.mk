################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua) e95eb4e
################################################################################b851f91

PKG_NAME="emulationstation"
PKG_VERSION="f63dca5"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/RetroPie/EmulationStation"
PKG_URL="https://github.com/RetroPie/EmulationStation/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="EmulationStation*"
PKG_DEPENDS_TARGET="toolchain systemd SDL2 boost freetype curl cmake:host freeimage eigen vlc libpng"
PKG_SECTION="xmedia/games"
PKG_SHORTDESC="Emulationstation emulator frontend"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

# theme for Emulationstation
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET emulationstation-theme-simple-dark"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET emulationstation-theme-carbon"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET emulationstation-theme-tronkyfran"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET emulationstation-theme-crt"


post_makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp $PKG_DIR/scripts/* $INSTALL/usr/bin
    chmod +x $INSTALL/usr/bin/*

  mkdir -p $INSTALL/usr/config/emulationstation
    cp $PKG_DIR/config/* $INSTALL/usr/config/emulationstation
}
