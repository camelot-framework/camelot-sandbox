#!/bin/bash

echo "Usage: sh restore.sh <hazelcast container index (default 1)>"

index=${1:-1}
echo "Modyfing hazelcast$index's iptables..."
docker exec 'camelotsandbox_hazelcast'$index'_1' iptables -P FORWARD ACCEPT
docker exec 'camelotsandbox_hazelcast'$index'_1' iptables -P INPUT ACCEPT
docker exec 'camelotsandbox_hazelcast'$index'_1' iptables -P OUTPUT ACCEPT

echo "Traffic exclusions removed, iptables now looks like this:"
docker exec 'camelotsandbox_hazelcast'$index'_1' iptables -L
