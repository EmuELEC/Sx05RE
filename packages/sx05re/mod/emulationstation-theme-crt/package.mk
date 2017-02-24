################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="emulationstation-theme-crt"
PKG_VERSION="486011c"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/anthonycaccese/es-theme-crt"
PKG_URL="https://github.com/anthonycaccese/es-theme-crt/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="es-theme-crt*"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="xmedia/games"
PKG_SHORTDESC="A simple theme for Emulation Station with support for the video view"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  : not
}

makeinstall_target() {
  mkdir -p $INSTALL/etc/emulationstation/themes/es-theme-crt
    cp -r * $INSTALL/etc/emulationstation/themes/es-theme-crt
}
