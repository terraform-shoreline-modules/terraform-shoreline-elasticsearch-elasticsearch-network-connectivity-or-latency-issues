
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Elasticsearch Network Connectivity or Latency Issues.

This incident type refers to issues related to network connectivity or latency in Elasticsearch, which is an open source search and analytics engine. These issues can result in slow performance, timeouts, or even complete unavailability of the Elasticsearch service. The root cause of such incidents could be a variety of factors such as network congestion, hardware failure, configuration errors, or software bugs.

### Parameters

```shell
export ELASTICSEARCH_HOST="PLACEHOLDER"
export PORT="PLACEHOLDER"
export TIMEOUT_VALUE="PLACEHOLDER"
```

## Debug

### Check if Elasticsearch service is running

```shell
systemctl status elasticsearch
```

### Check Elasticsearch logs for errors

```shell
journalctl -u elasticsearch --since "10 minutes ago"
```

### Ping Elasticsearch host

```shell
ping ${ELASTICSEARCH_HOST}
```

### Check network connectivity to Elasticsearch host

```shell
nc -vz ${ELASTICSEARCH_HOST} ${PORT}
```

### Check Elasticsearch cluster health status

```shell
curl -X GET "http://${ELASTICSEARCH_HOST}:${PORT}/_cluster/health"
```

### Check Elasticsearch node status

```shell
curl -X GET "http://${ELASTICSEARCH_HOST}:${PORT}/_nodes/stats"
```

### Check Elasticsearch indices

```shell
curl -X GET "http://${ELASTICSEARCH_HOST}:${PORT}/_cat/indices?v"
```

## Repair

### Increase the timeout settings for Elasticsearch to allow more time for requests to complete.

```shell
bash
#!/bin/bash

# Set the Elasticsearch timeout value (in milliseconds)
es_timeout=${TIMEOUT_VALUE}

# Update the Elasticsearch configuration file to increase the timeout value
sudo sed -i "s/.*timeout:.*/timeout: ${es_timeout}/" /etc/elasticsearch/elasticsearch.yml

# Restart the Elasticsearch service to apply the new configuration
sudo systemctl restart elasticsearch.service
```