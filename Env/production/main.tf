provider "google" {
  project = "${var.project_id}"
}

locals {
  name = "bowtie"
}

#VPC
resource "google_compute_network" "vpc" {
  name = "${local.name}-production"
  project = var.project_id
  auto_create_subnetworks = false
}

#Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "bowtie-production-central"
  ip_cidr_range = "10.2.0.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc.id
  }

#firewall
resource "google_compute_firewall" "bowtie-fw" {
  name    = "${local.name}-allow-http"
  network = google_compute_network.vpc.id
  project = var.project_id
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags   = ["bowtie-http"]
  source_ranges = ["0.0.0.0/0"]
}

#VM
resource "google_compute_instance" "bowtie-VM" {
  name         = "${local.name}-webserver"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  tags = ["server1"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
subnetwork = google_compute_subnetwork.subnet.id
    access_config {
      // Ephemeral public IP
    }
  }

  metadata_startup_script = file("./startup.sh")
}
