# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-ubuntu:jammy

# set version label
ARG BUILD_DATE
ARG VERSION
ARG WHISPER_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thespad"

ENV HOME=/config


RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    build-essential git \
    python3-dev \
    python3-venv && \
  python3 -m venv /lsiopy && \
  pip install -U --no-cache-dir \
    pip \
    wheel && \
  pip install git+https://github.com/sanchit-gandhi/whisper-jax.git && \
  apt-get purge -y --auto-remove \
    build-essential git \
    python3-dev && \
  rm -rf \
    /var/lib/apt/lists/* \
    /tmp/*

COPY wyoming /wyoming

COPY root/ /

VOLUME /config

EXPOSE 7860 
EXPOSE 10300
