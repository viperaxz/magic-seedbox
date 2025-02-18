variable "gcp_credentials" {
  description = "GCP Service Account JSON (from environment secrets)"
  sensitive   = true
}

variable "cloudflare_token" {
  description = "Cloudflare API token (from environment secrets)"
  sensitive   = true
}

variable "domain" {
  description = "Base domain for services"
  type        = string
}

variable "gcp_project" {
  description = "GCP Project ID from variables"
  type        = string
}

variable "gcp_region" {
  description = "GCP region"
  type        = string
  default     = "europe-west3"
}

variable "gcp_zone" {
  description = "GCP zone"
  type        = string
  default     = "europe-west3-a"
}