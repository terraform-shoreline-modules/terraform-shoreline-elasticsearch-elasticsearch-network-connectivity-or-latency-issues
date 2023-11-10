terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "elasticsearch_network_connectivity_or_latency_issues" {
  source    = "./modules/elasticsearch_network_connectivity_or_latency_issues"

  providers = {
    shoreline = shoreline
  }
}