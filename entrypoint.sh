#!/bin/bash

# 集群配置
cp config/cluster.ini .klei/DoNotStarveTogether/Cluster_1/cluster.ini

# 分片配置
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
