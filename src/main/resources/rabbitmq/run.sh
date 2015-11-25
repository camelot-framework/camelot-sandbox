#!/usr/bin/env bash

sleep 5

echo $(getent hosts rabbitmq1.dc | awk '{ print $1 }')' rabbitmq1' >> /etc/hosts
echo $(getent hosts rabbitmq2.dc | awk '{ print $1 }')' rabbitmq2' >> /etc/hosts

if [ $(hostname) == "rabbitmq2" ]
then
    echo "Waiting while primary node warming up..."
    sleep 10
fi
rabbitmq-server