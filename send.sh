#!/bin/bash
echo "//usage: sh send-mult.sh <count for each key (def. 10)> <keys (def. 10)> <delay sec (def. 0)> <host (def. 'localhost')> <port (def. 18081)>"

times=${1:-10}
keys=${2:-10}
sleep=${3:-0}
host=${4:-'localhost'}
port=${5:-18081}

for i in $(seq 1 $times); do
  for j in $(seq 1 $keys); do
    key="body-$j"
    echo "$key, #$i -> $(curl -s 'http://'$host':'$port'/collect/put?key='$key)"
    sleep $sleep
  done
done
