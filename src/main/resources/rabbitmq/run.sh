#!/usr/bin/env bash

echo $(getent hosts rabbitmq1.dc | awk '{ print $1 }')' rabbitmq1' >> /etc/hosts
echo $(getent hosts rabbitmq2.dc | awk '{ print $1 }')' rabbitmq2' >> /etc/hosts

rabbitmq-server