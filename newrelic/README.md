# Observing a GridGain cluster with New Relic

We'll use the OpenTelemetry Java agent to extract metrics from GridGain
and export them into New Relic. We assume a basic GridGain installation
on bare-metal or a VM. More sophisticated approaches may be available
when deploying to Kubernetes.

In short, the steps we'll take are as follows:

1. Find your New Relic account details
2. Download the OpenTelemetry Java agent
3. Configure GridGain to use the agent

## Find your New Relic account details

Log into your New Relic account. Find your API key:

1. Click your username in the bottom-left of the screen
2. Select API keys
3. Find the correct licence key of type "INGEST - LICENCE"
4. Click the "..." menu to the right, and select "Copy key"

## Download OpenTelemetry

Get the latest version of the [OpenTelemetry Java
agent](https://github.com/open-telemetry/opentelemetry-java-instrumentation) and make sure there's a copy on each of your GridGain
nodes.

## Configure GridGain to use the agent.

For your server, you'll likely set the necessary parameters in your
`JVM_OPTS`. For example:

```shell
export JVM_OPTS="-Xmx5g -XX:+UseG1GC -DIGNITE_QUIET=false \
-Djava.net.preferIPv4Stack=true \
-javaagent:$AGENT_PATH/opentelemetry-javaagent.jar \
-Dotel.exporter.otlp.endpoint=$NEW_RELIC_ENDPOINT \
-Dotel.exporter.otlp.headers=api-key=$NEW_RELIC_API \
-Dotel.service.name=$SERVICE_NAME \
-Dotel.jmx.config=$NEW_RELIC_CONFIG/gridgain-newrelic.yaml"
```

The `$NEW_RELIC_ENDPOINT` is `https://otlp.eu01.nr-data.net:4317` if
you're in the US and `https://otlp.nr-data.net:4317/` otherwise. (Check
the New Relic documentation for the most up-to-date information.)

The `$NEW_RELIC_API` is the code you found in your account above.

The `$SERVICE_NAME` is the name of the cluster or application. This can
be anything you like, but should uniquely identify the entire cluster.
An example might be `gridgain-prod`.

To identify your GridGain nodes in New Relic, you should name them. It's
recommended to use the consistent ID for example:

```shell
export OTEL_RESOURCE_ATTRIBUTES=service.instance.id=gridgain-prod-node-1
```

If you'd like to collect logs in New Relic, you should also set the
following:

```shell
export OTEL_EXPORTER_OTLP_COMPRESSION=gzip
export OTEL_LOGS_EXPORTER=otlp
```

The [sample startup script](nr-start.sh) includes all the above
parameters.

## Customisation

The [sample configuration file](gridgain-newrelic.yaml) maps many of
GridGain's JMX metrics to New Relic. Other metrics may need to be
imported depending on your requirements.

The [sample dashboard](dashboard.json) follows a similar pattern. You
can view the dashboard by following these steps:

1. Click "Dashboard" in the menu bar on the left side of the New Relic interface
2. At the top right of the screen, click "Import dashboard"
3. Copy the JSON from the sample dashboard and paste it into the dialog
4. Click "Import dashboard"
