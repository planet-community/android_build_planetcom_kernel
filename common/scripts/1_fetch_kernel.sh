#!/usr/bin/env bash

# fetch kernel sources
git clone \
  -b ${1:-stock} \
  https://github.com/cawilliamson/android_kernel_planetcomputing_astro.git \
  /usr/src/kernel

# git reset to specific git commit
if [ $# -eq 2 ]; then
  pushd /usr/src/kernel
    git reset --hard "${2}"
  popd
fi
