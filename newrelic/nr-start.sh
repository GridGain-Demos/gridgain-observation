#!/usr/bin/env bash

INSTANCE=gridgain-${1-0}

export IGNITE_HOME=$HOME/Downloads/gridgain-ultimate-8.8.28
AGENT_PATH=/Users/stephen.darlington/Downloads
NEW_RELIC_ENDPOINT=https://otlp.eu01.nr-data.net
NEW_RELIC_API=XXXX
NEW_RELIC_CONFIG=$HOME/gridgain/newrelic
SERVICE_NAME=gridgain-prod

# Generic parameters
export JVM_OPTS="-Xmx5g -XX:+UseG1GC -DIGNITE_QUIET=false \
-DIGNITE_CONSISTENT_ID=$gridgain-node-${INSTANCE} \
-Djava.net.preferIPv4Stack=true \
-javaagent:$AGENT_PATH/opentelemetry-javaagent.jar \
-Dotel.exporter.otlp.endpoint=$NEW_RELIC_ENDPOINT \
-Dotel.exporter.otlp.headers=api-key=$NEW_RELIC_API \
-Dotel.service.name=$SERVICE_NAME \
-Dotel.jmx.config=$NEW_RELIC_CONFIG/gridgain-newrelic.yaml"

# This is our node name
export OTEL_RESOURCE_ATTRIBUTES=service.instance.id=gridgain-node-${INSTANCE}

# Enable log collection
export OTEL_EXPORTER_OTLP_COMPRESSION=gzip
export OTEL_LOGS_EXPORTER=otlp

$IGNITE_HOME/bin/ignite.sh
