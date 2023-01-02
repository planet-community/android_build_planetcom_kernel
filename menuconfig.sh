#!/usr/bin/env bash

docker build -t buildkernel_astro .
docker run -it \
  -v $(pwd)/out:/out \
  buildkernel_astro \
  /bin/bash -c " \
    /opt/common/scripts/1_fetch_kernel.sh ${1} && \
    /opt/common/scripts/2_build_menuconfig.sh ${1}
  "
