################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="PPSSPPSDL"
PKG_VERSION="b94ad12"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/hrydgard/ppsspp.git"
PKG_URL="none"
PKG_DEPENDS_TARGET="toolchain ffmpeg libzip libpng SDL2 zlib zip linux"
PKG_SHORTDESC="PPSSPPDL"
PKG_LONGDESC="PPSSPP Standalone"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"


PKG_CMAKE_OPTS_TARGET="-DUSING_FBDEV=1  \
                       -DUSING_GLES2=1  \
                       -DUSE_FFMPEG=1  \
                       -DARMV7=1  \
		       -DSHARED_LIBZIP=1 \
                       -DARM_NEON=1"


unpack() { 
 cp $PKG_DIR/zipconf.h $SYSROOT_PREFIX/usr/include/zipconf.h 
 git clone --recursive https://github.com/hrydgard/ppsspp.git $PKG_BUILD
  cd $PKG_BUILD
  git reset --hard $PKG_VERSION
  rm -rf .git
  cd $ROOT
 
}


pre_configure_target() {
strip_lto
}

make_target() {

make
}


makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    #cp $INSTALL/PPSSPPDL $INSTALL/usr/bin/PPSSPPDL
    cp `find . -name "PPSSPPSDL" | xargs echo` $INSTALL/usr/bin/PPSSPPSDL
 #mkdir -p $INSTALL/usr/bin/
    cp -r `find . -name "assets" | xargs echo` $INSTALL/usr/bin/
} 
