################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="hurrican"
PKG_VERSION="bd9cbe9"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/meveric/hurrican"
PKG_URL="https://github.com/meveric/hurrican/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="hurrican*"
PKG_DEPENDS_TARGET="toolchain SDL2"
PKG_PRIORITY="optional"
PKG_SECTION="sx05re"
PKG_SHORTDESC="Hurrican (a Turrican Clone) for ODROID boards "
PKG_LONGDESC="Hurrican (a Turrican Clone) for ODROID boards "

PKG_IS_ADDON="no"
PKG_AUTORECONF="no" 
#-DPLATFORM_SDL -DUSE_GL2 -DUSE_GLES2 -DUSE_EGL_SDL -DUSE_MODPLUG -DENABLE_CONSOLE_COMMANDS
PKG_CONFIGURE_OPTS_TARGET="-DPLATFORM_SDL -DUSE_GL2 -DUSE_GLES2 -DUSE_EGL_SDL -DUSE_MODPLUG -DENABLE_CONSOLE_COMMANDS"


pre_configure_target() {
  strip_lto
}

make_target() {
cd Hurrican/src
make -f Makefile
 }


