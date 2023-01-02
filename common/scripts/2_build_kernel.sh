#!/usr/bin/env bash

# change working directory
cd /usr/src/kernel

ARCH=arm64
PATH=$PATH:/usr/src/kernel/tools
export ANDROID_MAJOR_VERSION ARCH PATH PLATFORM_VERSION

BUILD_CC=/opt/clang/bin/clang
BUILD_CLANG_TRIPLE=/opt/gcc/bin/aarch64-linux-gnu-
BUILD_CROSS_COMPILE=/opt/gcc/bin/aarch64-linux-android-
export BUILD_CC BUILD_CLANG_TRIPLE BUILD_CROSS_COMPILE

mkdir -p out/

make -C $(pwd) \
  O=$(pwd)/out \
  CC=$BUILD_CC \
  CLANG_TRIPLE=$BUILD_CLANG_TRIPLE \
  CROSS_COMPILE=$BUILD_CROSS_COMPILE \
  ${1:-k6873v1_64_defconfig}

make -j$(nproc --all) -C $(pwd) \
  O=$(pwd)/out \
  CC=$BUILD_CC \
  CLANG_TRIPLE=$BUILD_CLANG_TRIPLE \
  CROSS_COMPILE=$BUILD_CROSS_COMPILE
