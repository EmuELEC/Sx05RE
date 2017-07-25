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
PKG_VERSION="035cca8"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/mickelson/attract"
PKG_URL="https://github.com/mickelson/attract/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="attract-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain SFML openal-soft fontconfig freetype ffmpeg"
PKG_SECTION="sx05re/mod"
PKG_SHORTDESC="Attract mode"
PKG_LONGDESC="A graphical front-end for command line emulators that hides the underlying operating system and is intended to be controlled with a joystick or gamepad. "
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"


post_unpack() {
  rm -rf $BUILD/$PKG_NAME-*/
  git clone $PKG_SITE $BUILD/$PKG_NAME-$PKG_VERSION/
  cd $BUILD/$PKG_NAME-$PKG_VERSION/
  git checkout $PKG_VERSION
  git submodule update --init
  cd $ROOT
}

make_target() {
  make USE_GLES=1
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp `find . -name "attract" | xargs echo` $INSTALL/usr/bin
}
