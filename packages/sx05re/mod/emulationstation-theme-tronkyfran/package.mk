################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="emulationstation-theme-tronkyfran"
PKG_VERSION="9acd98b"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/HerbFargus/es-theme-tronkyfran"
PKG_URL="https://github.com/HerbFargus/es-theme-tronkyfran/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="es-theme-tronkyfran*"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="xmedia/games"
PKG_SHORTDESC="Tronkyfran theme for Emulationstation"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  : not
}

makeinstall_target() {
  mkdir -p $INSTALL/etc/emulationstation/themes/es-theme-tronkyfran
    cp -r * $INSTALL/etc/emulationstation/themes/es-theme-tronkyfran
}
