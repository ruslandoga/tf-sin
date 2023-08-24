terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }

  cloud {
    organization = "since"

    workspaces {
      name = "ocean"
    }
  }
}

variable "do_token" {}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_tag" "since" {
  name = "since"
}

resource "digitalocean_tag" "since_backend" {
  name = "since-backend"
}

resource "digitalocean_tag" "since_database" {
  name = "since-database"
}

locals {
  droplet_count = 1
  region        = "fra1"
}
