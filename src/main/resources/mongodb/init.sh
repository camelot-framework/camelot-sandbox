#!/bin/bash

cat <<-JS > /tmp/mongoinit.js
    rs.initiate({"_id":"sandbox","members":[
        {"_id":1,"host":"mongodb1.dc:27017"},
        {"_id":2,"host":"mongodb2.dc:27017"},
        {"_id":3,"host":"mongodb3.dc:27017"},
    ]});
JS

while ! nc -z mongodb1.dc 27017; do
  sleep 0.1
done
/usr/bin/mongo --host mongodb1.dc /tmp/mongoinit.js
while ! nc -z mongodb2.dc 27017; do
  sleep 0.1
done
/usr/bin/mongo --host mongodb2.dc /tmp/mongoinit.js
while ! nc -z mongodb3.dc 27017; do
  sleep 0.1
done
/usr/bin/mongo --host mongodb3.dc /tmp/mongoinit.js
