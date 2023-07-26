# GridGain Observation

## Overview

[GridGain](https://www.gridgain./com) provides extensive diagnostic
information in a range of industry-standard formats, including JMX,
OpenCensus and OpenTracing. This means that it can be integrated with
almost any observation platform, though the method of doing so is not
always entirely obvious. This repo includes sample configurations and
guides for integrating with a number of different systems.

This is my no means a complete list. The absence of a provider should
not be construed as GridGain not working well with it. Instead, it means
either that we do not come across it on a regular basis, or that
integration is trivial and we have never been asked to help.

These guides should not be considered as "production ready"
configurations. Rather, they are starting points. The exact metrics that
you should monitor and alert on depend on your cluster's workload and
the facilities that you're using. Please talk to GridGain to discuss
your requirements.

Note that these guides should generally work unchanged with Apache
Ignite, though they may not have been tested.

## General

All the systems that GridGain connects to use the same underlying
metrics framework. There are some minor differences. For example,
OpenCensus is very specifically designed to export _metrics_, that is,
_numbers_ that relate to particular aspect of the system. JMX, on the
other hand, is more general and can expose lists of things and strings.
However, if it's possible to export them, all metrics are available
everywhere.

This means that you won't get "better" metrics by switching from, say,
JMX to Open Census. The integration might be more direct or easier, but
the metrics will be the same.

A corollary of this is that if you're getting the "wrong" numbers in one
tool, switching to another won't help.

The most common gotcha is that some metrics are disabled by default.
Make sure the following are enabled in your cluster:

* Cache. Enable metrics by setting the `StatisticsEnabled` property to true
* Data Storage. Enable by setting the `MetricsEnabled` property to true
* Data Region. Enable by setting the `MetricsEnabled` property to true

Cache metrics can be enabled at runtime. Data region and data storage
metrics require a node restart.

## GridGain Control Center

[GridGain Control
Center](https://www.gridgain.com/docs/control-center/latest/overview) is
a management and monitoring tool for GridGain and Apache Ignite
clusters. It features a graphical user interface that helps you perform
administrative tasks and monitor your clusters.

GridGain includes native support for Control Center. Sign up for the
SaaS version [here](https://portal.gridgain.com).
