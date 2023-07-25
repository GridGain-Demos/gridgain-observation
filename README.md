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

## GridGain Control Center

[GridGain Control
Center](https://www.gridgain.com/docs/control-center/latest/overview) is
a management and monitoring tool for GridGain and Apache Ignite
clusters. It features a graphical user interface that helps you perform
administrative tasks and monitor your clusters.

GridGain includes native support for Control Center. Sign up for the
SaaS version [here](https://portal.gridgain.com).
