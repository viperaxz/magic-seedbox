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

# Configure GCP Provider
provider "google" {
  credentials = var.gcp_credentials  # From GitHub secret
  project     = var.gcp_project      # From GitHub variable
  region      = var.gcp_region
}

# Configure Cloudflare Provider
provider "cloudflare" {
  api_token = var.cloudflare_token  # From GitHub secret
}