#!/usr/bin/env bash

cat <<XML > /opt/hazelcast/hazelcast.xml
<?xml version="1.0" encoding="UTF-8"?>
<hazelcast xsi:schemaLocation="http://www.hazelcast.com/schema/config hazelcast-config-3.5.xsd"
           xmlns="http://www.hazelcast.com/schema/config"
           xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <properties>
        <property name="hazelcast.logging.type">jdk</property>
        <property name="hazelcast.max.no.heartbeat.seconds">15</property>
    </properties>
    <group>
        <name>sandbox</name>
        <password>sandbox</password>
    </group>
    <network>
        <port auto-increment="false">5701</port>
        <join>
            <multicast enabled="false">
                <multicast-group>224.2.2.3</multicast-group>
                <multicast-port>54327</multicast-port>
            </multicast>
            <tcp-ip enabled="true">
                <interface>$DNSDOCK_ALIAS</interface>
                <member-list>
                    <member>hazelcast1.dc:5701</member>
                    <member>hazelcast2.dc:5701</member>
                    <member>hazelcast3.dc:5701</member>
                </member-list>
            </tcp-ip>
        </join>
    </network>
    <quorum name="quorumTwo" enabled="true">
        <quorum-size>2</quorum-size>
    </quorum>
    <map name="default">
        <quorum-ref>quorumTwo</quorum-ref>
        <in-memory-format>BINARY</in-memory-format>
        <backup-count>1</backup-count>
        <async-backup-count>0</async-backup-count>
        <time-to-live-seconds>0</time-to-live-seconds>
        <max-idle-seconds>0</max-idle-seconds>
        <eviction-policy>LRU</eviction-policy>
        <max-size policy="PER_NODE">1000000</max-size>
        <eviction-percentage>25</eviction-percentage>
        <min-eviction-check-millis>100</min-eviction-check-millis>
        <merge-policy>com.hazelcast.map.merge.LatestUpdateMapMergePolicy</merge-policy>
    </map>
</hazelcast>
XML

cd $HZ_HOME
MEMORY_OPTS="-XX:MaxPermSize=512m -Xms512m -Xmx1024m"
java $MEMORY_OPTS -server -cp hazelcast-$HZ_VERSION.jar com.hazelcast.core.server.StartServer
