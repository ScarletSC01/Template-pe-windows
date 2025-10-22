data "google_compute_image" "windows_image" {
  family  = var.OS_TYPE
  project = "windows-cloud"
}

resource "google_compute_instance" "vm_instance" {
  name         = var.VM_NAME
  machine_type = "${var.VM_TYPE}-${var.VM_CORES}"
  zone         = var.ZONE

  boot_disk {
    initialize_params {
      image = data.google_compute_image.windows_image.self_link
      size  = var.DISK_SIZE
      type  = var.DISK_TYPE
    }
    auto_delete = tobool(var.AUTO_DELETE_DISK)
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.name

    dynamic "access_config" {
      for_each = tobool(var.PUBLIC_IP) ? [1] : []
      content {}
    }
  }

  scheduling {
    preemptible       = var.INFRAESTRUCTURE_TYPE == "Preemptible"
    automatic_restart = var.INFRAESTRUCTURE_TYPE == "On-demand"
  }

  service_account {
    email  = var.SERVICE_ACCOUNT
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  metadata_startup_script = tobool(var.ENABLE_STARTUP_SCRIPT) ? file("startup.ps1") : null
  deletion_protection     = tobool(var.ENABLE_DELETION_PROTECTION)

  labels = { for pair in split(",", var.LABEL) : split("=", pair)[0] => split("=", pair)[1] }

  tags = split(",", var.FIREWALL_RULES)
}
