#!/bin/bash

SCRIPT_DIR=$(dirname "$0")
RUN=$(date "+%H%M%S")
LABEL="RUN_$RUN"
LIB="$(readlink -f $SCRIPT_DIR/network-patterns-all.jar)"
CMD_PREFIX=""
LOG_DIR="$LABEL"
WARMUP_MESSAGES="500000"
RUNTIME_MINUTES="15"
SERVER_LISTEN_ADDRESS=${OVERRIDE_SERVER_LISTEN_ADDRESS:-"127.0.0.1"}
CLIENT_LISTEN_ADDRESS=${OVERRIDE_CLIENT_LISTEN_ADDRESS:-"127.0.0.1"}
SERVER_TCP_PORT="7786"
CLIENT_TCP_PORT="7788"
SERVER_UDP_PORT="15678"
CLIENT_UDP_PORT="15680"
CLIENT_IN_CPU=${OVERRIDE_CLIENT_IN_CPU:-"5"}
CLIENT_OUT_CPU=${OVERRIDE_CLIENT_OUT_CPU:-"6"}
SERVER_IN_CPU=${OVERRIDE_SERVER_IN_CPU:-"7"}
SERVER_OUT_CPU=${OVERRIDE_SERVER_OUT_CPU:-"7"}
POOL_CPUS=${OVERRIDE_POOL_CPUS:-"1,2,3"}
USER_CPUSET=${OVERRIDE_USER_CPUSET:-"client_set"}
OVERRIDE_IRQ_CPUS="0,4"
OVERRIDE_SYSTEM_CPUS="0,4"
OVERRIDE_RESTRICTED_CPUS="1,2,3,5,6,7"


JAVA_ARGS="-cp $LIB -Dnetwork-patterns.warmupMessages=$WARMUP_MESSAGES \
-Djava.net.preferIPv4Stack=true \
-Dnetwork-patterns.runtimeMinutes=$RUNTIME_MINUTES \
-Dnetwork-patterns.bindAddress=$SERVER_LISTEN_ADDRESS \
-Dnetwork-patterns.clientBindAddress=$CLIENT_LISTEN_ADDRESS -XX:-TieredCompilation \
-XX:+UnlockDiagnosticVMOptions -XX:+PrintSafepointStatistics -XX:+TraceBiasedLocking \
-XX:+PrintBiasedLockingStatistics -XX:PrintSafepointStatisticsCount=1 \
-XX:+PrintGCApplicationStoppedTime -XX:BiasedLockingStartupDelay=500"
