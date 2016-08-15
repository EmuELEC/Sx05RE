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

PKG_NAME="media_build"
PKG_VERSION="6931070"

# choose "LATEST" or a date like "2014-12-01-e8bd888" for the driver package
# chose from here http://linuxtv.org/downloads/drivers/

# working
# 2016-03-29-d3f519301944
# 2016-05-02-68af062b5f38
# 2016-06-16-0db5c79989de
MEDIA_BUILD_VERSION="2016-07-18-009a62084821"

PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://git.linuxtv.org/media_build.git"
PKG_URL="http://mycvh.de/openelec/$PKG_NAME/$PKG_NAME-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET=""
PKG_BUILD_DEPENDS_TARGET="toolchain linux"
PKG_PRIORITY="optional"
PKG_SECTION="driver"
PKG_SHORTDESC="Build system to use the latest experimental drivers/patches from latest Kernel version"
PKG_LONGDESC="Build system to use the latest experimental drivers/patches from latest Kernel version"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_make_target() {
  export KERNEL_VER=$(get_module_dir)
  # dont use our LDFLAGS, use the KERNEL LDFLAGS
  export LDFLAGS=""
}

make_target() {
  $SED -i  -e "/^LATEST_TAR/s/-LATEST/-$MEDIA_BUILD_VERSION/g" linux/Makefile
  make VER=$KERNEL_VER SRCDIR=$(kernel_path) -C linux/ download
  make VER=$KERNEL_VER SRCDIR=$(kernel_path) -C linux/ untar
  make VER=$KERNEL_VER SRCDIR=$(kernel_path) stagingconfig
  make VER=$KERNEL_VER SRCDIR=$(kernel_path)
}

makeinstall_target() {
  mkdir -p $INSTALL/lib/modules/$KERNEL_VER/updates/media_build
  find $ROOT/$PKG_BUILD/v4l/ -name \*.ko -exec strip --strip-debug {} \;
  find $ROOT/$PKG_BUILD/v4l/ -name \*.ko -exec cp {} $INSTALL/lib/modules/$KERNEL_VER/updates/media_build \;
}

pre_install() {
  # modules are installed under this name
  KNAME_THIS=$PKG_NAME
  # compare with
  KNAME_CMP=sys

  KVER=$(get_module_dir)
  KDIR_ROOT=$INSTALL/lib/modules/${KVER}
  KDIR_SYS=$INSTALL/lib/modules/${KVER}-sys
  KDIR_THIS=$INSTALL/lib/modules/${KVER}-$KNAME_THIS
  KDIR_CMP=$INSTALL/lib/modules/${KVER}-$KNAME_CMP
  echo "$KDIR_ROOT" "$KDIR_SYS"

  if [ -d "$KDIR_SYS" ]; then
    echo "folder $KDIR_SYS must not exist"
    exit 1
  fi

  cp -aP "$KDIR_ROOT" "$KDIR_SYS"
}

post_install() {
  find $KDIR_ROOT/* -type f -name *.ko | while read f1; do
    f2=$(echo "$f1" | sed "s|$KDIR_ROOT/||")

    if [ -f $KDIR_ROOT/$f2 -a -f $KDIR_CMP/$f2 ]; then
      md5_new=$(md5sum $KDIR_ROOT/$f2 | cut -d ' ' -f1)
      md5_cmp=$(md5sum $KDIR_CMP/$f2 | cut -d ' ' -f1)
      if [ "$md5_new" = "$md5_cmp" ]; then
        # use hard link from compared kernel
        ln -f "$KDIR_CMP/$f2" "$KDIR_ROOT/$f2"
      fi
    fi

    # todo: check if there can be symbolic link for module file
  done

  # run depmod
  MODVER=${KVER}

  find $INSTALL/lib/modules/$MODVER/ -name *.ko | \
    sed -e "s,$INSTALL/lib/modules/$MODVER/,," > $INSTALL/lib/modules/$MODVER/modules.order
  $ROOT/$TOOLCHAIN/bin/depmod -b $INSTALL $MODVER 2>/dev/null

  # strip kernel modules
  for MOD in $(find $INSTALL/lib/modules/$MODVER -type f -name *.ko); do
    $STRIP --strip-debug $MOD || : # ignore
  done

  # rename to new folder
  rm -fr "$KDIR_THIS"
  mv "$KDIR_ROOT" "$KDIR_THIS"

  # rename sys folder back
  mv "$KDIR_SYS" "$KDIR_ROOT"

  echo "${KVER}-$KNAME_THIS" >>$INSTALL/lib/modules/.kernel_modules_dir
}
