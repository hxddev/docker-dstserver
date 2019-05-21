#!/bin/bash

# cp /home/dstserver/config/cluster.ini /home/dstserver/.klei/DoNotStarveTogether/Cluster_1/cluster.ini
# cp /home/dstserver/config/dedicated_server_mods_setup.lua /home/dstserver/serverfiles/mods/dedicated_server_mods_setup.lua
# cp /home/dstserver/config/modoverrides.lua /home/dstserver/.klei/DoNotStarveTogether/Cluster_1/Master/modoverrides.lua

echo $CLUSTER_TOKEN > /home/dstserver/.klei/DoNotStarveTogether/Cluster_1/cluster_token.txt

# ./dstserver start

tail -f /dev/null
