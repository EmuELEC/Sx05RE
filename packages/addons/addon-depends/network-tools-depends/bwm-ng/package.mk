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

PKG_NAME="bwm-ng"
PKG_VERSION="0.6.1"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gropp.org/?id=projects&sub=bwm-ng"
PKG_URL="http://www.gropp.org/bwm-ng/bwm-ng-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain ncurses libstatgrab"
PKG_PRIORITY="optional"
PKG_SECTION="network/analyzer"
PKG_SHORTDESC="bwm-ng: small and simple console-based live network and disk io bandwidth monitor"
PKG_LONGDESC="Bandwidth Monitor NG is a small and simple console-based live network and disk io bandwidth monitor for Linux, BSD, Solaris, Mac OS X and others."
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--with-libstatgrab \
                           --with-time \
                           --with-getifaddrs \
                           --with-sysctl \
                           --with-sysctldisk \
                           --with-procnetdev \
                           --with-partitions"

post_unpack() {
  $SED "s:<curses.h>:<ncurses.h>:g" $PKG_BUILD/src/defines.h
}

pre_configure_target() {
  export CFLAGS="$CFLAGS -I$SYSROOT_PREFIX/usr/include/ncurses"
}

makeinstall_target() {
  : # nop
}
