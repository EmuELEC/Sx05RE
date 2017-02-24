################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="libretro-beetle-pce-fast"
PKG_VERSION="39185a6"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/libretro/beetle-pce-fast-libretro"
PKG_URL="https://github.com/libretro/beetle-pce-fast-libretro/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="beetle-pce-fast-libretro-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="xmedia/games"
PKG_SHORTDESC="Optimized port of VBA-M to Libretro"
PKG_LONGDESC="Optimized port of VBA-M to Libretro"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  make ARCH="" CC="$CC" NATIVE_CC="$CC" LD="$CC" -j 1
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
    cp `find . -name "*.so" | xargs echo` $INSTALL/usr/lib/libretro/
}
