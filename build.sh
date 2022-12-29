#!/usr/bin/env bash

docker build -t buildkernel_astro .
docker run \
  -v $(pwd)/out:/out \
  buildkernel_astro \
  /bin/bash -c " \
    /opt/common/scripts/1_fetch_kernel.sh $1 $2 && \
    /opt/common/scripts/2_build_kernel.sh && \
    /opt/common/scripts/3_copy_kernel.sh && \
    /opt/common/scripts/4_fix_permissions.sh \
  "
