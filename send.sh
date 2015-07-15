#!/usr/bin/env bash
for i in {1..100}
do
    for j in {1..10}
    do
        curl -I http://localhost:18081/collect/put?key=body$j
    done
done
