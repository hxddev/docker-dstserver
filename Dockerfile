FROM gameservermanagers/linuxgsm-docker

# 复制所有配置文件到容器
RUN mkdir config
COPY config config

# 复制并设置入口脚本
COPY entrypoint.sh /entrypoint.sh