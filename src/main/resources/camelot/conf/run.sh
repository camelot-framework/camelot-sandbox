#!/usr/bin/env bash
echo $(getent hosts rabbitmq1.dc | awk '{ print $1 }')' rabbitmq1' >> /etc/hosts
echo $(getent hosts rabbitmq2.dc | awk '{ print $1 }')' rabbitmq2' >> /etc/hosts
sleep 25
mkdir -p /etc/camelot/log
touch /etc/camelot/log/camelot-full.log
/etc/camelot/bin/camelot.sh start
tail -f /etc/camelot/log/camelot-full.log