#!/usr/bin/env bash

# change working directory
cd /usr/src/kernel 

ARCH=arm64
PATH=$PATH:/usr/src/kernel/tools
export ANDROID_MAJOR_VERSION ARCH PATH PLATFORM_VERSION

CC=/opt/clang/bin/clang
CLANG_TRIPLE=/opt/clang/bin/aarch64-linux-gnu-
CROSS_COMPILE=/opt/clang/bin/aarch64-linux-android-
export CC CLANG_TRIPLE CROSS_COMPILE

mkdir -p out/

make -C $(pwd) \
  O=$(pwd)/out \
  $KERNEL_MAKE_ENV \
  CROSS_COMPILE=$BUILD_CROSS_COMPILE \
  REAL_CC=$KERNEL_LLVM_BIN \
  CLANG_TRIPLE=$CLANG_TRIPLE \
  k6873v1_64_defconfig

make -C $(pwd) \
  O=$(pwd)/out \
  $KERNEL_MAKE_ENV \
  CROSS_COMPILE=$BUILD_CROSS_COMPILE \
  REAL_CC=$KERNEL_LLVM_BIN \
  CLANG_TRIPLE=$CLANG_TRIPLE \
  menuconfig

# remove previous defconfig
rm -f /out/defconfig

# copy defconfig out
cp -fv \
  /usr/src/kernel/out/.config \
  /out/defconfig
