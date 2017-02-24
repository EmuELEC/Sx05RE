################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)c533113
################################################################################

PKG_NAME="libretro-glupen64"
PKG_VERSION="7b7cb25"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/loganmc10/GLupeN64"
PKG_URL="none"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="xmedia/games"
PKG_SHORTDESC="mupen64plus + RSP-HLE + GLideN64 + libretro"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

unpack() {
  git clone --recursive https://github.com/loganmc10/GLupeN64.git $PKG_BUILD
  cd $PKG_BUILD
  git reset --hard $PKG_VERSION
  cd $ROOT
}

pre_build_target() {
  strip_lto
}

make_target() {
  case $PROJECT in
    RPi2)
      make platform=rpi2
      ;;
    PC)
      make
      ;;
    *)
      make platform=linux-gles GLES=1 FORCE_GLES=1 HAVE_NEON=1 WITH_DYNAREC=arm
      ;;
  esac
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
    cp `find . -name "*.so" | xargs echo` $INSTALL/usr/lib/libretro/
}
