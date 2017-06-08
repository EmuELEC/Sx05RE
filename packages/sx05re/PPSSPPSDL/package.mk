################################################################################
#      This file is part of LibreELEC - http://www.libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="PPSSPPSDL"
PKG_VERSION="15aff3d"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/hrydgard/ppsspp.git"
PKG_URL="https://github.com/hrydgard/"
PKG_DEPENDS_TARGET="toolchain ffmpeg libzip libpng SDL2 zlib zip linux"
PKG_SHORTDESC="PPSSPPDL"
PKG_LONGDESC="PPSSPP Standalone"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$TARGET_ARCH" == "aarch64" ]; then

PKG_CMAKE_OPTS_TARGET="-DUSING_FBDEV=1  \
                       -DUSING_GLES2=1  \
                       -DUSE_FFMPEG=1  \
                       -DARM64=1  \
		       -DSHARED_LIBZIP=1 \
                       -DARM_NEON=1"
else
PKG_CMAKE_OPTS_TARGET="-DUSING_FBDEV=1  \
                       -DUSING_GLES2=1  \
                       -DUSE_FFMPEG=1  \
                       -DARMV7=1  \
		       -DSHARED_LIBZIP=1 \
                       -DARM_NEON=1"
fi

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
    cp $PKG_DIR/ppsspp.sh $INSTALL/usr/bin/ppsspp.sh
    cp `find . -name "PPSSPPSDL" | xargs echo` $INSTALL/usr/bin/PPSSPPSDL
 #mkdir -p $INSTALL/usr/bin/
    cp -r `find . -name "assets" | xargs echo` $INSTALL/usr/bin/
} 
