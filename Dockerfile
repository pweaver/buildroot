# Copyright 2018 Abstact, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM debian:9.4-slim
LABEL maintainer="Pweaver <me@pweaver.org>"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    bash \
    bc \
    binutils \
    build-essential \
    bzip2 \
    cpio \
    g++ \
    gcc \
    gpg \
    git \
    gzip \
    locales \
    libncurses5-dev \
    make \
    patch \
    perl \
    python \
    rsync \
    sed \
    tar \
    unzip \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.utf8

# GPG signature for buildroot releases
COPY buildroot_pubkey.gpg buildroot_pubkey.gpg

ARG buildroot_version=2018.02
RUN export FILE=buildroot-$buildroot_version.tar.bz2 && \
    gpg --import buildroot_pubkey.gpg && \
    wget -q https://buildroot.org/downloads/$FILE.sign && \
    gpg --verify $FILE.sign && \
    wget -q https://buildroot.org/downloads/$FILE && \
    grep SHA1: $FILE.sign | cut -d ' ' -f '2,3,4' | shasum -c - && \
    mkdir -p /buildroot && \
    tar -xjf $FILE  -C /buildroot --strip-components=1 && \
    rm -rf $FILE* /root/.gnupg buildroot_pubkey.gpg

WORKDIR /buildroot

CMD ["make", "help"]
