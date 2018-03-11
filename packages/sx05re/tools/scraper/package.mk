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

PKG_NAME="scraper"
PKG_VERSION="1.4.5"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/sselph/scraper"
PKG_URL="https://github.com/sselph/scraper/releases/download/v$PKG_VERSION/scraper_rpi2.zip"
PKG_SOURCE_DIR="scraper"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="sx05re"
PKG_SHORTDESC="A scraper for EmulationStation written in Go using hashing"
PKG_LONGDESC="A scraper for EmulationStation written in Go using hashing"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no" 

pre_unpack() {
mkdir -p $BUILD/$PKG_SOURCE_DIR-$PKG_VERSION
}

post_unpack() {
mv $BUILD/scraper $BUILD/$PKG_SOURCE_DIR-$PKG_VERSION
rm $BUILD/LICENSE.txt
}

make_target() {
: not 
}

makeinstall_target() {
mkdir -p $INSTALL/usr/bin/
    cp $BUILD/$PKG_SOURCE_DIR-$PKG_VERSION/* $INSTALL/usr/bin/
}

