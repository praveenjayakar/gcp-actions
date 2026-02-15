provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}
#added new line
#added line from dev branch


variable "project_id" {}
variable "region" {}
variable "zone" {}
variable "machine_type" {}


resource "google_compute_instance" "linux_vm" {
  name         = "ai-agent-linux-vm"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-12"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  tags = ["ai-agent", "linux"]
}


output "vm_public_ip" {
  value = google_compute_instance.linux_vm.network_interface[0].access_config[0].nat_ip
}


