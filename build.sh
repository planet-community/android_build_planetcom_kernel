#!/usr/bin/env bash



docker build -t buildkernel_astro .
docker run \
  -v $(pwd)/out:/out \
  -v $(pwd)/common/files/android_boot_a_astro.img:/var/tmp/input_boot.img \
  buildkernel_astro \
  00_build.sh "astroslide"
