#!/usr/bin/env bash
echo $(getent hosts qpid.dc | awk '{ print $1 }')' qpid' >> /etc/hosts
sleep 20
mkdir -p /etc/camelot/log
touch /etc/camelot/log/camelot-full.log
/etc/camelot/bin/camelot.sh start
tail -f /etc/camelot/log/camelot-full.log