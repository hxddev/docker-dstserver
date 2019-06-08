FROM ubuntu

# 安装服务器环境
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
  iproute2 \
  vi

# 设置用户和工作目录
RUN useradd -ms /bin/bash dstserver
USER dstserver
WORKDIR /home/dstserver

# 下载并初始化环境
RUN wget -O linuxgsm.sh https://linuxgsm.sh \
  && chmod +x linuxgsm.sh \
  && bash linuxgsm.sh dstserver \
  && ./dstserver auto-install

# 复制所有配置文件到容器
RUN mkdir config
COPY config config

# 覆盖 LGSM 安装配置文件
RUN cd /home/dstserver/.klei/ && ls
RUN cp -f config/_default.cfg lgsm/config-default/config-lgsm/dstserver/_default.cfg \
  && cp config/caves/install.cfg lgsm/config-lgsm/dstserver/dstserver-caves.cfg \
  && cp config/master/install.cfg lgsm/config-lgsm/dstserver/dstserver-master.cfg

# 复制脚本并修改名称
RUN cp dstserver dstserver-master
RUN mv dstserver dstserver-caves

# 安装服务
RUN ./dstserver-master auto-install; exit 0
RUN ./dstserver-caves auto-install; exit 0

# 覆盖集群配置
RUN cp config/cluster.ini .klei/DoNotStarveTogether/Cluster_1/cluster.ini

# 覆盖分片配置
RUN cp config/caves/server.ini .klei/DoNotStarveTogether/Cluster_1/Caves/server.ini
RUN cp config/master/server.ini .klei/DoNotStarveTogether/Cluster_1/Master/server.ini

# 数据卷
VOLUME [ "/home/dstserver" ]

# 复制并设置入口脚本
COPY entrypoint.sh entrypoint.sh
ENTRYPOINT ["bash", "entrypoint.sh" ]