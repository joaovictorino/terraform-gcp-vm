terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.51.0"
    }
  }
}

provider "google" {
  project = "teste-sample-388301"
  region  = "us-central1"
}

resource "google_project_service" "cloud_resource_manager" {
  service            = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "compute" {
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_network" "vpc-aula" {
  name = "vpc-aula"
}

resource "google_compute_address" "ip-aula" {
  name = "ip-aula"
}

resource "google_compute_firewall" "firewall-aula" {
  name          = "firewall-aula"
  network       = google_compute_network.vpc-aula.name
  target_tags   = ["allow-ssh"]
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_instance" "vm-aula" {
  name         = "vm-aula"
  machine_type = "f1-micro"

  metadata = {
    ssh-keys = "ubuntu:${file("id_rsa.pub")}"
  }

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network = google_compute_network.vpc-aula.name

    access_config {
      nat_ip = google_compute_address.ip-aula.address
    }
  }
  tags =  ["allow-ssh"]
}

output "public_ip" {
  value = google_compute_address.ip-aula.address
}
