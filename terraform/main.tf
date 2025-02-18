# Rest of your infrastructure code...
resource "google_compute_instance" "seedbox" {
  name         = "magic-seedbox"
  machine_type = "e2-micro"
  zone         = var.gcp_zone

  boot_disk {
    initialize_params {
      image = "ubuntu-2204-lts"
    }
  }

  metadata = {
    user-data = file("${path.module}/../cloud-init/user-data.yaml")
  }

  network_interface {
    network = "default"
    access_config {}
  }

  tags = ["magic-seedbox"]
}

resource "google_compute_firewall" "allow_ports" {
  name    = "magic-seedbox-ports"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "9090", "8080"]
  }

  allow {
    protocol = "udp"
    ports    = ["51820"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["magic-seedbox"]
}

output "vm_ip" {
  value = google_compute_instance.seedbox.network_interface[0].access_config[0].nat_ip
}