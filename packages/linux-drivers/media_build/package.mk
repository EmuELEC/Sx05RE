################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
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

PKG_NAME="media_build"
PKG_VERSION="2016-12-28"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/crazycat69/linux_media"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_BUILD_DEPENDS_TARGET="toolchain linux"
PKG_SECTION="driver"
PKG_SHORTDESC="DVB drivers that replace the version shipped with the kernel"
PKG_LONGDESC="DVB drivers that replace the version shipped with the kernel"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_make_target() {
  export KERNEL_VER=$(get_module_dir)
  export LDFLAGS=""
}

make_target() {

  # Amlogic AMLVIDEO driver
  if [ -e "$(kernel_path)/drivers/amlogic/video_dev" ]; then

    # Copy, patch and enable amlvideodri module
    cp -a "$(kernel_path)/drivers/amlogic/video_dev" "media/drivers/media/"
    sed -i 's,common/,,g; s,"trace/,",g' $(find media/drivers/media/video_dev/ -type f)
    sed -i 's,\$(CONFIG_V4L_AMLOGIC_VIDEO),m,g' "media/drivers/media/video_dev/Makefile"
    echo "obj-y += video_dev/" >> "media/drivers/media/Makefile"
    echo "source drivers/media/video_dev/Kconfig " >> "media/drivers/media/Kconfig"

    # Copy and enable videobuf-res module
    cp -a "$(kernel_path)/drivers/media/v4l2-core/videobuf-res.c" "media/drivers/media/v4l2-core/"
    cp -a "$(kernel_path)/include/media/videobuf-res.h" "media/include/media/"
    echo "obj-m += videobuf-res.o" >> "media/drivers/media/v4l2-core/Makefile"

    # Use meson-ir module from kernel tree, patch it and force to be built
    if [ -e "$(kernel_path)/drivers/media/rc/meson-ir.c" ]; then
      cp -a "$(kernel_path)/drivers/media/rc/meson-ir.c" "media/drivers/media/rc/"
      sed -i 's,allowed_protos,allowed_protocols,g' "media/drivers/media/rc/meson-ir.c"
      echo "obj-m += meson-ir.o" >> "media/drivers/media/rc/Makefile"
    fi

  fi

  cd media_build
  make dir DIR=../media
  make VER=$KERNEL_VER SRCDIR=$(kernel_path) allyesconfig
  make VER=$KERNEL_VER SRCDIR=$(kernel_path)
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/modules/$KERNEL_VER/updates
  find $ROOT/$PKG_BUILD/media_build/v4l/ -name \*.ko -exec cp {} $INSTALL/usr/lib/modules/$KERNEL_VER/updates \;
}
