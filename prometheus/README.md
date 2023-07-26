# Observing a GridGain cluster with New Relic

[Prometheus](https://prometheus.io/) is a popular monitoring tool
supported by the [Cloud Native Computing
Foundation](https://www.cncf.io/), the same people as Kubernetes.

In short, the steps we take are as follows:

1. Enable the Open Census module in GridGain
2. Build a JAR that includes an embedded webserver to allow Prometheus
to scrape GridGain's metrics
3. Configure GridGain to enable Open Census metrics and to start the web
server on startup
4. Start our GridGain node

## Enable OpenCensus

Enable GridGain's Open Census support by:

1. Go into $IGNTITE_HOME/libs/optional
2. Move the ignite-opencensus directory up a level (`mv ignite-opencensus ..`)

## Build our support JAR

Build a copy of the required libraries:

```shell
mvn package
```

This module is not strictly necessary. You can "manually" create the list of dependent JAR files. I found
this easier.

## Configure GridGain

An example of all the configuration options can be found
[here](src/main/resources/ignite-prometheus.xml).

More information on configuring GridGain to [enable OpenCensus
metrics](https://www.gridgain.com/docs/latest/administrators-guide/monitoring-metrics/generic-metrics)
can be found in the documentation.

We also need to start a small HTTP endpoint for Prometheus to access the
metrics.

## Start GridGain node

Start GridGain as follows:

```shell
export USER_LIBS=/full/path/to/ignite-prometheus-1.0-SNAPSHOT-jar-with-dependencies.jar
$IGNITE_HOME/bin/ignite.sh .../src/main/resources/ignite-prometheus.xml
```

You can then open http://localhost:9000 in your web browser to see the
raw statistics (wait a minute or two if only a few are present).

Point your Prometheus installation at your nodes. To test locally, you
can start Prometheus with the following command:

```shell
prometheus --config.file=ignite-prometheus.yaml
```
