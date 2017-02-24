################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="core-info"
PKG_VERSION="adb2940"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-super"
PKG_URL="https://github.com/libretro/libretro-super/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="libretro-super*"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="xmedia/games"
PKG_SHORTDESC="Info files for libretro cores"
PKG_LONGDESC="Super repo for other libretro projects. Fetches, builds and installs."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  : none
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp dist/info/*.info $INSTALL/usr/lib/libretro/
}
