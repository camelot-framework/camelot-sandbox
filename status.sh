#!/bin/bash

docker exec 'camelotsandbox_hazelcast'$1'_1' iptables -L
