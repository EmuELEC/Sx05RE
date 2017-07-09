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

PKG_NAME="emulationstation"
PKG_VERSION="2decb2b"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/RetroPie/EmulationStation"
PKG_URL="https://github.com/RetroPie/EmulationStation/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="EmulationStation*"
PKG_DEPENDS_TARGET="toolchain systemd SDL2 boost freetype curl cmake:host freeimage eigen vlc libpng"
PKG_SECTION="xmedia/games"
PKG_SHORTDESC="Emulationstation emulator frontend"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

# theme for Emulationstation
#PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET emulationstation-theme-simple-dark"
#PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET emulationstation-theme-carbon"
#PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET emulationstation-theme-nes-mini"
#PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET emulationstation-theme-tronkyfran"
#PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET emulationstation-theme-crt"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET emulationstation-theme-ComicBook"

post_unpack() {
mkdir -p $PKG_BUILD/external/pugixml 
 git clone https://github.com/zeux/pugixml.git $PKG_BUILD/external/pugixml
}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp $PKG_DIR/scripts/* $INSTALL/usr/bin
    chmod +x $INSTALL/usr/bin/*

  mkdir -p $INSTALL/usr/config/emulationstation
    cp $PKG_DIR/config/* $INSTALL/usr/config/emulationstation
  
   mkdir -p $INSTALL/etc/emulationstation/
   ln -sf /storage/.config/emulationstation/themes $INSTALL/etc/emulationstation/
}
