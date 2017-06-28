################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
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
PKG_VERSION="2017-06-20-rpi"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/crazycat69/linux_media"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_BUILD_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="driver"
PKG_SHORTDESC="DVB drivers that replace the version shipped with the kernel"
PKG_LONGDESC="DVB drivers that replace the version shipped with the kernel"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$TARGET_KERNEL_ARCH" = "arm64" -a "$TARGET_ARCH" = "arm" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET gcc-linaro-aarch64-linux-gnu:host"
  export PATH=$ROOT/$TOOLCHAIN/lib/gcc-linaro-aarch64-linux-gnu/bin/:$PATH
  TARGET_PREFIX=aarch64-linux-gnu-
fi

if [ "$PROJECT" = "S905" ] || [ "$PROJECT" = "S912" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET dvb_tv-aml"
fi

pre_make_target() {
  export KERNEL_VER=$(get_module_dir)
  export LDFLAGS=""
}

make_target() {
  make untar

  # copy config file
  if [ "$PROJECT" = Generic ] || [ "$PROJECT" = Virtual ]; then
    if [ -f $PKG_DIR/config/generic.config ]; then
      cp $PKG_DIR/config/generic.config v4l/.config
    fi
  elif [ "$PROJECT" != "S805" ] && [ "$PROJECT" != "S905" ] && [ "$PROJECT" != "S912" ]; then
    if [ -f $PKG_DIR/config/usb.config ]; then
      cp $PKG_DIR/config/usb.config v4l/.config
    fi
  fi

  # add menuconfig to edit .config

  # Amlogic AMLVIDEO driver
  if [ -e "$(kernel_path)/drivers/amlogic/video_dev" ]; then

    # Copy, patch and enable amlvideodri module
    cp -a "$(kernel_path)/drivers/amlogic/video_dev" "linux/drivers/media/"
    sed -i 's,common/,,g; s,"trace/,",g' $(find linux/drivers/media/video_dev/ -type f)
    sed -i 's,\$(CONFIG_V4L_AMLOGIC_VIDEO),m,g' "linux/drivers/media/video_dev/Makefile"
    echo "obj-y += video_dev/" >> "linux/drivers/media/Makefile"

    # Copy and enable videobuf-res module
    cp -a "$(kernel_path)/drivers/media/v4l2-core/videobuf-res.c" "linux/drivers/media/v4l2-core/"
    cp -a "$(kernel_path)/include/media/videobuf-res.h" "linux/include/media/"
    echo "obj-m += videobuf-res.o" >> "linux/drivers/media/v4l2-core/Makefile"

  fi

  # Amlogic DVB driver
  if [ "$PROJECT" = "S905" ] || [ "$PROJECT" = "S912" ]; then
    DVB_TV_AML_DIR="$(get_build_dir dvb_tv-aml)"
    if [ -d "$DVB_TV_AML_DIR" ]; then
      cp -a "$DVB_TV_AML_DIR" "linux/drivers/media/dvb_tv"
      echo "obj-y += dvb_tv/" >> "linux/drivers/media/Makefile"
    fi 
    echo "obj-y += amlogic/dvb_tv/" >> "linux/drivers/media/Makefile"

  # Meson-IR driver
    echo "obj-m += meson-ir.o" >> "linux/drivers/media/rc/Makefile"
  fi

  make VER=$KERNEL_VER SRCDIR=$(kernel_path)
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/modules/$KERNEL_VER/updates
  find $ROOT/$PKG_BUILD/v4l/ -name \*.ko -exec cp {} $INSTALL/usr/lib/modules/$KERNEL_VER/updates \;
}
