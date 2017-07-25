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

PKG_NAME="jum52"
PKG_VERSION="0e37207"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/r-type/jum52"
PKG_URL="https://github.com/r-type/jum52/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Jum52 Atari 5200 emulator cross-platform for libretro/libco WIP"
PKG_LONGDESC="Jum52 Atari 5200 emulator cross-platform for libretro/libco WIP"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no" 


#post_unpack() {
#  mv $BUILD/jum52-$PKG_VERSION* $BUILD/$PKG_NAME-$PKG_VERSION
#}

pre_configure_target() {
  strip_lto
}

make_target() {
cd driver_Libretro
make -f Makefile.libretro

 }

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp jum52_libretro.so $INSTALL/usr/lib/libretro/
  cp jum52_libretro.info $INSTALL/usr/lib/libretro/
  cp jum52.cfg $INSTALL/usr/lib/libretro/
}

