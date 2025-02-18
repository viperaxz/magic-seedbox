terraform {
  required_version = ">= 1.5.5"
  
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.21"  # Version constraint only here
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project     = var.gcp_project
  region      = var.gcp_region
  credentials = file(var.gcp_credentials_file) 
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}