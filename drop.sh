#!/bin/bash

echo "Usage: sh drop.sh <hazelcast container index (default 1)>"

index=${1:-1}
echo "Modyfing hazelcast$index's iptables..."
docker exec 'camelotsandbox_hazelcast'$index'_1' iptables -P FORWARD DROP
docker exec 'camelotsandbox_hazelcast'$index'_1' iptables -P INPUT DROP
docker exec 'camelotsandbox_hazelcast'$index'_1' iptables -P OUTPUT DROP

echo "Traffic exclusions added, iptables now looks like this:"
docker exec 'camelotsandbox_hazelcast'$index'_1' iptables -L
