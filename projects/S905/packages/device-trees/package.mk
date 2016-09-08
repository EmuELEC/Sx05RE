################################################################################
#      This file is part of LibreELEC - http://www.libreelec.tv
#      Copyright (C) 2016 Mateusz Krzak (kszaquitto@gmail.com)
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

PKG_NAME="device-trees"
PKG_VERSION="0.1"
PKG_REV="1"
PKG_ARCH="aarch64"
PKG_LICENSE="OSS"
PKG_DEPENDS_TARGET="toolchain linux"

PKG_AUTORECONF="no"

EXTRA_TREES=(gxbb_p201.dtb)

make_target() {
  pushd $ROOT/$BUILD/linux-$(kernel_version) > /dev/null

  mkdir -p $TARGET_IMG

  # Complete device trees
  for f in $PKG_DIR/sources/*.dts; do
    if [ -e $f ]; then
      DTB_NAME="$(basename $f .dts).dtb"
      cp -f $f arch/$TARGET_KERNEL_ARCH/boot/dts/amlogic/
      LDFLAGS="" make $DTB_NAME
      mv arch/$TARGET_KERNEL_ARCH/boot/dts/amlogic/$DTB_NAME $TARGET_IMG
    fi
  done

  # Patched device trees
  for f in $PKG_DIR/sources/*.patch; do
    if [ -e $f ]; then
      DTB_NAME="$(basename $f .patch).dtb"
      DTS_NAME="$(basename $f .patch).dts"
      patch -d arch/$TARGET_KERNEL_ARCH/boot/dts/amlogic/ -o $DTS_NAME < $f
      LDFLAGS="" make $DTB_NAME
      mv arch/$TARGET_KERNEL_ARCH/boot/dts/amlogic/$DTB_NAME $TARGET_IMG
    fi
  done

  # Kernel-tree trees
  for f in ${EXTRA_TREES[@]}; do
    LDFLAGS="" make $f
    mv arch/$TARGET_KERNEL_ARCH/boot/dts/amlogic/$f $TARGET_IMG
  done

  popd > /dev/null
}

makeinstall_target() {
  : # nop
}
