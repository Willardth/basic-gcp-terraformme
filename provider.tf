terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.26.0"
    }
  }
}

provider "google" {
  # Configuration options
project = "class-5-freedom"
region = "us-central1"
zone = "us-central1-a"
credentials = "class-5-freedom-18233d823f57.json"



}