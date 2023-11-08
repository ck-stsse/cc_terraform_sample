terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.55.0"
    }
  }
}

# Option #1: Manage multiple clusters in the same Terraform workspace
provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key    # optionally use CONFLUENT_CLOUD_API_KEY env var
  cloud_api_secret = var.confluent_cloud_api_secret # optionally use CONFLUENT_CLOUD_API_SECRET env var
}


resource "confluent_connector" "sink" {
  environment {
    id = var.confluent_environment_id
  }
  kafka_cluster {
    id = var.confluent_kafka_cluster_id
  }

  // Block for custom *sensitive* configuration properties that are labelled with "Type: password" under "Configuration Properties" section in the docs:
  // https://docs.confluent.io/cloud/current/connectors/cc-s3-sink.html#configuration-properties
  config_sensitive = {
    "aws.access.key.id"     = var.aws_access_key_id
    "aws.secret.access.key" = var.aws_access_key_secret
  }

  // Block for custom *nonsensitive* configuration properties that are *not* labelled with "Type: password" under "Configuration Properties" section in the docs:
  // https://docs.confluent.io/cloud/current/connectors/cc-s3-sink.html#configuration-properties
  config_nonsensitive = {
    "topics"                   = var.confluent_kafka_topics
    "input.data.format"        = "BYTES"
    "connector.class"          = "S3_SINK"
    "name"                     = "S3_SINKConnector_TF"
    "kafka.auth.mode"          = "SERVICE_ACCOUNT"
    "kafka.service.account.id" = var.confluent_service_account_id
    "s3.bucket.name"           = var.s3_bucket_name
    "output.data.format"       = "BYTES"
    "time.interval"            = "HOURLY"
    "flush.size"               = "1000"
    "tasks.max"                = "1"
  }

  lifecycle {
    prevent_destroy = false
  }
}
