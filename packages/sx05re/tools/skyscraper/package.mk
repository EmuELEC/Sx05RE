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

PKG_NAME="skyscraper"
PKG_VERSION="62070a0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/muldjord/skyscraper"
PKG_URL="https://github.com/muldjord/skyscraper/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="skyscraper*"
PKG_DEPENDS_TARGET="toolchain qt-everywhere"
PKG_PRIORITY="optional"
PKG_SECTION="sx05re"
PKG_SHORTDESC="Powerful and versatile game scraper written in c++"
PKG_LONGDESC="Powerful and versatile game scraper written in c++ "

PKG_IS_ADDON="no"
PKG_AUTORECONF="no" 


make_target() {
# Nasty hack to get qmake to work, if you change qt-everywhere version, make sure you change this.
$BUILD/qt-everywhere-5.9.4/qtbase/qmake/qmake INSTALLDIR=${INSTALL}/usr/bin
cd $PKG_BUILD
make
}

makeinstall_target() {
make install
}



