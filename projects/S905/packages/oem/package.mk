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

PKG_NAME="oem"
PKG_VERSION=""
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="various"
PKG_SITE="http://www.openelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain rng-tools u-boot-tools"
PKG_PRIORITY="optional"
PKG_SECTION="virtual"
PKG_SHORTDESC="OEM: Metapackage for various OEM packages"
PKG_LONGDESC="OEM: Metapackage for various OEM packages"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

post_install() {
  if [ -n "$DEVICE" -a -d "$PROJECT_DIR/$PROJECT/devices/$DEVICE/filesystem" ]; then
    cp -LR $PROJECT_DIR/$PROJECT/devices/$DEVICE/filesystem/* $ROOT/$BUILD/image/system
  fi
}


 # sx05re
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET emulationstation"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET retroarch"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET mupen64plus-libretro"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libretro-pcsx_rearmed"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libretro-genesis-plus-gx"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libretro-snes9x2010"
 # PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libretro-mame2003"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libretro-fbalpha"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libretro-fuse"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libretro-nestopia"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libretro-picodrive"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libretro-vba-next"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libretro-gambatte"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libretro-beetle-pce-fast"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET stella"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET prosystem"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET atari800"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libretro-parallel-n64"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET ppsspp"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET advmame"
 # PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libretro-ppsspp"
 # PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET PPSSPPDL"
