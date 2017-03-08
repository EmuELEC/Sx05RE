################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="freeimage"
PKG_VERSION="3170"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="http://freeimage.sourceforge.net/"
PKG_URL="http://downloads.sourceforge.net/freeimage/FreeImage$PKG_VERSION.zip"
PKG_SOURCE_DIR="FreeImage"
PKG_DEPENDS_TARGET="toolchain libpng"
PKG_SECTION="xmedia/games"
PKG_SHORTDESC="FreeImage library"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

  
make_target() {
  make DESTDIR=$SYSROOT_PREFIX 
}
