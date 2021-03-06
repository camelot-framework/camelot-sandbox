# Camelot Sandbox

Example allowing to launch camelot plugin project with the default single-node environment

## Prerequisites
* Docker >= 1.6.2
* Docker Compose >= 1.3.1
* JDK >= 1.7
* Maven >= 3.13
* Boot2Docker (on Mac)

## How to use
* Clone project
* Build project
```bash
$ mvn clean package -Dcamelot.version=2.2.2-SNAPSHOT
```
* Run environment
```bash
$ docker-compose up -d
```
* Send messages via
```bash
$ curl http://localhost:18082/collect/put?key={AGG_KEY}
```
or if you are on Mac:
```bash
$ curl http://$(boot2docker ip):18082/collect/put?key={AGG_KEY}
```

* Get state via
```bash
$ curl http://localhost:18082/collect/get?key={AGG_KEY}
```
or if you are on Mac:
```bash
$ curl http://$(boot2docker ip):18082/collect/get?key={AGG_KEY}
```
