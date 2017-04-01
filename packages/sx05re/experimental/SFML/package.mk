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

PKG_NAME="SFML"
PKG_VERSION="40ae477"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/SFML/SFML"
PKG_URL="https://github.com/SFML/SFML/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="SFML-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain libX11 libXrandr opengl-meson"
PKG_SECTION="sx05re/mod"
PKG_SHORTDESC="Attract mode"
PKG_LONGDESC="A graphical front-end for command line emulators that hides the underlying operating system and is intended to be controlled with a joystick or gamepad. "
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="-DSFML_OPENGL_ES=TRUE"

make_target() {
  make -DSFML_OPENGL_ES=TRUE
}
