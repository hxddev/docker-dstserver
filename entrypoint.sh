#!/bin/bash

# 下载 dstserver
linuxgsm.sh dstserver && ./dstserver auto-install

# 覆盖 LGSM 安装配置文件
cp -f config/_default.cfg lgsm/config-default/config-lgsm/dstserver/_default.cfg
cp config/caves/install.cfg lgsm/config-lgsm/dstserver/dstserver-caves.cfg
cp config/master/install.cfg lgsm/config-lgsm/dstserver/dstserver-master.cfg

# 复制脚本并修改名称
cp dstserver dstserver-master
mv dstserver dstserver-caves

# 安装服务
./dstserver-master auto-install
./dstserver-caves auto-install

# 覆盖集群配置
cp config/cluster.ini .klei/DoNotStarveTogether/Cluster_1/cluster.ini

# 覆盖分片配置
cp config/caves/server.ini .klei/DoNotStarveTogether/Cluster_1/Caves/server.ini
cp config/master/server.ini .klei/DoNotStarveTogether/Cluster_1/Master/server.ini

# 设置 Token
echo $CLUSTER_TOKEN > .klei/DoNotStarveTogether/Cluster_1/cluster_token.txt

# 设置 Mods
cp config/mods/dedicated_server_mods_setup.lua serverfiles/mods/dedicated_server_mods_setup.lua
cp config/mods/modoverrides.lua .klei/DoNotStarveTogether/Cluster_1/Caves/modoverrides.lua
cp config/mods/modoverrides.lua .klei/DoNotStarveTogether/Cluster_1/Master/modoverrides.lua

# 启动服务器
./dstserver-caves start
./dstserver-master start

tail -f /dev/null
