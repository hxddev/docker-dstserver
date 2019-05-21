#!/bin/bash

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
