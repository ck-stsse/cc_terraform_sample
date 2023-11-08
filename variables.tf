variable "confluent_cloud_api_key" {
  description = "Confluent Cloud API Key (also referred as Cloud API ID)"
  type        = string
}

variable "confluent_cloud_api_secret" {
  description = "Confluent Cloud API Secret"
  type        = string
  sensitive   = true
}

variable "confluent_environment_id" {
  description = "Confluent Cloud Environment Id"
  type        = string
  sensitive   = true
}

variable "confluent_kafka_cluster_id" {
  description = "Confluent Cloud Cluster Id"
  type        = string
  sensitive   = true
}

variable "confluent_service_account_id" {
  description = "Confluent Service Account Id"
  type        = string
  sensitive   = true
}

variable "aws_access_key_id" {
  description = "AWS Access Key Id"
  type        = string
  sensitive   = true
}

variable "aws_access_key_secret" {
  description = "AWS Access Key Secret"
  type        = string
  sensitive   = true
}

variable "confluent_kafka_topics" {
  description = "List of topics"
  type        = string
  sensitive   = true
}

variable "s3_bucket_name" {
  description = "Destination S3 bucket"
  type        = string
  sensitive   = true
}



