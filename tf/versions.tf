terraform {
  required_version = ">= 0.13"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.39.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.39.0"
    }
  }
}
