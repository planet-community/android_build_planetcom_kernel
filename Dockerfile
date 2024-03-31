FROM ubuntu:latest

ARG CLANG_VERSION=4691093

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C

RUN apt update \
    && apt -y upgrade \
    && apt -y dist-upgrade \
    && apt -y install \
          bc \
          bison \
          build-essential \
          cpio \
          curl \
          flex \
          git \
          kmod \
          libncurses-dev \
          libncurses5 \
          libssl-dev \
          python-is-python3 \
          python2 \ 
          python3 \
          python3-pip \
          wget \
          xz-utils \
          zip \
    && mkdir -p /opt/gcc \
    && curl -s "https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/+archive/refs/heads/pie-release.tar.gz" | tar xzf - -C /opt/gcc \
    && curl -s "https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/pie-release.tar.gz" | tar xzf - -C /opt/ \
    && ln -sf /opt/clang-${CLANG_VERSION} /opt/clang \
    && mkdir /opt/unpackbootimg \
    && git clone --depth 1 --branch 2022.11.09 https://github.com/osm0sis/mkbootimg.git /opt/unpackbootimg \
    && cd /opt/unpackbootimg \
    && make CC=gcc

ADD ./common/ /opt/common/

ENV PATH="${PATH}:/opt/common/scripts"

ENTRYPOINT ["00_build.sh"]
