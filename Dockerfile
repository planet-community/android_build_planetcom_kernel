FROM ubuntu:latest

ARG CLANG_VERSION=4691093

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C

RUN apt update
RUN apt -y dist-upgrade
RUN apt -y install \
  bc \
  bison \
  build-essential \
  cpio \
  curl \
  flex \
  git \
  kmod \
  libncurses5 \
  libncurses-dev \
  libssl-dev \
  python-is-python3 \
  python2 \ 
  python3 \
  python3-pip \
  wget \
  xz-utils \
  zip

RUN curl -L -o /var/tmp/gcc.tar.gz https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/+archive/pie-release.tar.gz && \
  mkdir -p /opt/gcc && \
  tar -xvpf /var/tmp/gcc.tar.gz -C /opt/gcc && \
  rm -f /var/tmp/gcc.tar.gz

RUN curl -L -o /var/tmp/clang.tar.gz https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/pie-release.tar.gz && \
  tar -xvpf /var/tmp/clang.tar.gz -C /opt && \
  ln -sf /opt/clang-${CLANG_VERSION} /opt/clang && \
  rm -f /var/tmp/clang.tar.gz

RUN mkdir /opt/unpackbootimg && \
  git clone https://github.com/osm0sis/mkbootimg.git /opt/unpackbootimg && \
  cd /opt/unpackbootimg && \
  git checkout 2375c167cbcb10d1ea2c357b7f0a90625462f9be && \
  make CC=gcc

