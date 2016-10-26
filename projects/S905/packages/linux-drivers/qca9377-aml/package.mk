################################################################################
#      This file is part of LibreELEC - https://LibreELEC.tv
#      Copyright (C) 2016 Team LibreELEC
#      Copyright (C) 2016 kszaq
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

PKG_NAME="qca9377-aml"
PKG_REV="1"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="http://openlinux.amlogic.com:8000/download/ARM/wifi/"
PKG_VERSION="8b729b7"
PKG_URL="https://github.com/tomatotech/mmallow_hardware_wifi_qualcomm_drivers_qca9377/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="mmallow_hardware_wifi_qualcomm_drivers_qca9377-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="driver"
PKG_SHORTDESC="qca9377-aml"
PKG_LONGDESC="qca9377-aml"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  make oldconfig \
       -C AIO/drivers/backports \
       CC=gcc \
       KLIB=$INSTALL \
       KLIB_BUILD=$(kernel_path)
  cd AIO/drivers
  LDFLAGS="" CFLAGS="" make \
    BOARD_TYPE=x86-android \
    KLIB=$INSTALL \
    KERNELPATH=$(kernel_path) \
    KERNELARCH=$TARGET_KERNEL_ARCH \
    CROSS_COMPILE=$TARGET_PREFIX \
    ATH_TOPDIR=$ROOT/$PKG_BUILD/AIO \
    TOOLPREFIX=${CROSS_COMPILE} \
    CFG80211_NAME=backports \
    CONFIG_CFG80211_INTERNAL_REGDB=y \
    CONFIG_PMF_SUPPORT=y \
    CONFIG_CLD_HL_SDIO_CORE=y \
    CONFIG_LINUX_QCMBR=y \
    CONFIG_ROME_IF=sdio \
    MAKEARCH="make ARCH=$TARGET_KERNEL_ARCH CROSS_COMPILE=$TARGET_PREFIX"
}

makeinstall_target() {
  mkdir -p $INSTALL/lib/modules/$PKG_NAME
  find $ROOT/$PKG_BUILD/ -name cfg80211.ko -exec cp {} $INSTALL/lib/modules/$PKG_NAME \;
  find $ROOT/$PKG_BUILD/ -name compat.ko -exec cp {} $INSTALL/lib/modules/$PKG_NAME \;
  find $ROOT/$PKG_BUILD/ -name wlan.ko -exec cp {} $INSTALL/lib/modules/$PKG_NAME \;
}
