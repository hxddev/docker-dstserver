FROM ubuntu

RUN dpkg --add-architecture i386 \
  && apt update \
  && apt install -y \
  curl \
  tmux \
  wget \
  ca-certificates \
  file \
  bsdmainutils \
  util-linux \
  python \
  bzip2 \
  gzip \
  unzip \
  binutils \
  bc \
  jq \
  lib32gcc1 \
  libstdc++6:i386 \
  libcurl4-gnutls-dev:i386 \
  iproute2

RUN useradd -ms /bin/bash dstserver
USER dstserver
WORKDIR /home/dstserver

RUN wget -O linuxgsm.sh https://linuxgsm.sh \
  && chmod +x linuxgsm.sh \
  && bash linuxgsm.sh dstserver

RUN ./dstserver auto-install

RUN mkdir /home/dstserver/config
COPY ./config /home/dstserver/config

VOLUME [ "/home/dstserver/config" ]

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["bash","/entrypoint.sh" ]