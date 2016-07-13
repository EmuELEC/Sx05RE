################################################################################
#      This file is part of LibreELEC - https://LibreELEC.tv
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

PKG_NAME="media-backports"
PKG_VERSION="4.4.2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://backports.wiki.kernel.org"
PKG_URL="http://www.kernel.org/pub/linux/kernel/projects/backports/stable/v$PKG_VERSION/backports-$PKG_VERSION-$PKG_REV.tar.xz"
PKG_SOURCE_DIR="backports-$PKG_VERSION-$PKG_REV"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_PRIORITY="optional"
PKG_SECTION="driver"
PKG_SHORTDESC="Linux media drivers backports"
PKG_LONGDESC="Linux media drivers backports"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  make defconfig-media \
       CC=gcc \
       KLIB=$INSTALL \
       KLIB_BUILD=$(kernel_path)
  LDFLAGS="" CFLAGS="" make \
       KLIB=$INSTALL \
       KLIB_BUILD=$(kernel_path) \
       ARCH=$TARGET_KERNEL_ARCH \
       CROSS_COMPILE=$TARGET_PREFIX
}

makeinstall_target() {
  mkdir -p $INSTALL/lib/modules/$(get_module_dir)/updates/$PKG_NAME

  pushd $ROOT/$PKG_BUILD
  find compat/ -name \*.ko -exec cp --parents {} $INSTALL/lib/modules/$(get_module_dir)/updates/$PKG_NAME \;
  find drivers/ -name \*.ko -exec cp --parents {} $INSTALL/lib/modules/$(get_module_dir)/updates/$PKG_NAME \;
  popd
}
