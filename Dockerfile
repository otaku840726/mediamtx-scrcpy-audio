FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbullseye

ARG BUILD_DATE
ARG VERSION
# LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="rsmacapinlac"

ENV SCRCPY_IP="192.168.0.1"
ENV RTSP_SERVER="rtsp://192.168.0.1"

RUN \
    echo "**** install packages ****" && \
      # Update and install extra packages.
      echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
      apt-get update && \
      apt-get install -y \
        # Packages needed to download and extract obsidian.
        sudo \
        curl \
        python3-xdg \
        ffmpeg libsdl2-2.0-0 adb wget \
                 gcc git pkg-config meson ninja-build libsdl2-dev \
                 libavcodec-dev libavdevice-dev libavformat-dev libavutil-dev \
                 libswresample-dev libusb-1.0-0 libusb-1.0-0-dev \
        && \
    echo "**** cleanup ****" && \
        apt-get autoclean && \
        rm -rf \
        /var/lib/apt/lists/* \
        /var/tmp/* \
        /tmp/*

# install scrcpy
RUN \ 
     echo "****git clone****" && \
     git clone https://github.com/Genymobile/scrcpy && \
     cd scrcpy \
     echo "****execute sh***" && \
     ./install_release.sh

# add local files
COPY /root /

RUN chmod +x /entrypoint.sh

# volumes
VOLUME ["/config"]

