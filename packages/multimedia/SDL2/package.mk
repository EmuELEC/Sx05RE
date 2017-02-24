################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="SDL2"
PKG_VERSION="2.0.4"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://www.libsdl.org/"
PKG_URL="https://www.libsdl.org/release/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain yasm:host alsa-lib systemd dbus"
PKG_SECTION="multimedia"
PKG_SHORTDESC="SDL2: A cross-platform Graphic API"
PKG_LONGDESC="Simple DirectMedia Layer is a cross-platform multimedia library designed to provide fast access to the graphics framebuffer and audio device. It is used by MPEG playback software, emulators, and many popular games, including the award winning Linux port of 'Civilization: Call To Power.' Simple DirectMedia Layer supports Linux, Win32, BeOS, MacOS, Solaris, IRIX, and FreeBSD."
PKG_IS_ADDON="no"
PKG_USE_CMAKE="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="SYSROOT_PREFIX=$SYSROOT_PREFIX --enable-shared --enable-static \
                           --enable-libc \
                           --enable-gcc-atomics \
                           --enable-atomic \
                           --enable-audio \
                           --enable-render \
                           --enable-events \
                           --enable-joystick \
                           --enable-haptic \
                           --enable-power \
                           --enable-filesystem \
                           --enable-threads \
                           --enable-timers \
                           --enable-file \
                           --enable-loadso \
                           --enable-cpuinfo \
                           --enable-assembly \
                           --disable-altivec \
                           --disable-oss \
                           --enable-alsa --disable-alsatest --enable-alsa-shared \
                           --with-alsa-prefix=$SYSROOT_PREFIX/usr/lib \
                           --with-alsa-inc-prefix=$SYSROOT_PREFIX/usr/include \
                           --disable-esd --disable-esdtest --disable-esd-shared \
                           --disable-arts --disable-arts-shared \
                           --disable-nas --enable-nas-shared \
                           --disable-sndio --enable-sndio-shared \
                           --disable-diskaudio \
                           --disable-dummyaudio \
                           --disable-video-wayland --enable-video-wayland-qt-touch --disable-wayland-shared \
                           --disable-video-mir --disable-mir-shared \
                           --disable-video-cocoa \
                           --disable-video-directfb --disable-directfb-shared \
                           --disable-fusionsound --disable-fusionsound-shared \
                           --disable-video-dummy \
                           --enable-libudev \
                           --enable-dbus \
                           --disable-input-tslib \
                           --enable-pthreads --enable-pthread-sem \
                           --disable-directx \
                           --enable-sdl-dlopen \
                           --disable-clock_gettime \
                           --disable-rpath \
                           --disable-render-d3d \
                           --enable-video-mali"



  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --enable-video --disable-video-x11 --disable-x11-shared"
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-video-x11-xcursor --disable-video-x11-xinerama"
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-video-x11-xinput --disable-video-x11-xrandr"
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-video-x11-scrnsaver --disable-video-x11-xshape"
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-video-x11-vm --without-x"

if [ ! "$OPENGL" = "no" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OPENGL glu"

  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --enable-video-opengl --disable-video-opengles"
fi

if [ "$PULSEAUDIO_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET pulseaudio"

  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --enable-pulseaudio --enable-pulseaudio-shared"
else
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-pulseaudio --disable-pulseaudio-shared"
fi

pre_make_target() {
# dont build parallel
  MAKEFLAGS=-j1
}

post_makeinstall_target() {
  $SED "s:\(['=\" ]\)/usr:\\1$SYSROOT_PREFIX/usr:g" $SYSROOT_PREFIX/usr/bin/sdl2-config

  rm -rf $INSTALL/usr/bin
}
