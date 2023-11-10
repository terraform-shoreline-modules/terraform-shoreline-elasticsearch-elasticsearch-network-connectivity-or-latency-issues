resource "shoreline_notebook" "elasticsearch_network_connectivity_or_latency_issues" {
  name       = "elasticsearch_network_connectivity_or_latency_issues"
  data       = file("${path.module}/data/elasticsearch_network_connectivity_or_latency_issues.json")
  depends_on = [shoreline_action.invoke_update_es_timeout]
}

resource "shoreline_file" "update_es_timeout" {
  name             = "update_es_timeout"
  input_file       = "${path.module}/data/update_es_timeout.sh"
  md5              = filemd5("${path.module}/data/update_es_timeout.sh")
  description      = "Increase the timeout settings for Elasticsearch to allow more time for requests to complete."
  destination_path = "/tmp/update_es_timeout.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_update_es_timeout" {
  name        = "invoke_update_es_timeout"
  description = "Increase the timeout settings for Elasticsearch to allow more time for requests to complete."
  command     = "`chmod +x /tmp/update_es_timeout.sh && /tmp/update_es_timeout.sh`"
  params      = ["TIMEOUT_VALUE"]
  file_deps   = ["update_es_timeout"]
  enabled     = true
  depends_on  = [shoreline_file.update_es_timeout]
}

