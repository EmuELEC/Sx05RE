################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="attract"
PKG_VERSION="78cf4f6"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/mickelson/attract"
PKG_URL="https://github.com/mickelson/attract/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="attract-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain SFML openal-soft fontconfig freetype ffmpeg opengl-meson"
PKG_SECTION="sx05re/mod"
PKG_SHORTDESC="Attract mode"
PKG_LONGDESC="A graphical front-end for command line emulators that hides the underlying operating system and is intended to be controlled with a joystick or gamepad. "
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
 

make_target() {
 make CROSS=1 USE_GLES=1 EXTRA_CFLAGS="$CFLAGS -I$TOOLCHAIN/armv8a-libreelec-linux-gnueabi/sysroot/usr/include -L$TOOLCHAIN/armv8a-libreelec-linux-gnueabi/sysroot/usr/include" VER_MAJOR=1  TOOLCHAIN=$TOOLCHAIN/bin/armv8a-libreelec-linux-gnueabi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp `find . -name "attract" | xargs echo` $INSTALL/usr/bin
}
