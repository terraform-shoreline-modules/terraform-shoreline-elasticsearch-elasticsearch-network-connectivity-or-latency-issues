bash
#!/bin/bash

# Set the Elasticsearch timeout value (in milliseconds)
es_timeout=${TIMEOUT_VALUE}

# Update the Elasticsearch configuration file to increase the timeout value
sudo sed -i "s/.*timeout:.*/timeout: ${es_timeout}/" /etc/elasticsearch/elasticsearch.yml

# Restart the Elasticsearch service to apply the new configuration
sudo systemctl restart elasticsearch.service