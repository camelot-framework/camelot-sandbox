#!/bin/bash

echo "//usage: sh get.sh <key (def. 'body-1')> <host (def. 'localhost')> <port (def. 18081)>"

key=${1:-'body-1'}
host=${2:-'localhost'}
port=${3:-'18081'}

curl 'http://'$host':'$port'/collect/get?key='$key && echo
