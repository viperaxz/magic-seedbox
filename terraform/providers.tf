terraform {
  required_version = ">= 1.5.5"
  
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.21"  # For GCP
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"   # Cloudflare namespace
    }
  }
}