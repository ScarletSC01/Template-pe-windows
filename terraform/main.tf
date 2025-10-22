provider "google" {
  project = var.PROJECT_ID
  region  = var.REGION
  zone    = var.ZONE
}

# ================================================================
# CONFIGURACIÓN DE LA MÁQUINA VIRTUAL WINDOWS
# ================================================================

resource "google_compute_instance" "vm_windows" {
  name         = var.VM_NAME
  machine_type = "${var.VM_TYPE}-${var.VM_CORES}"

  boot_disk {
    initialize_params {
      image = "projects/windows-cloud/global/images/family/${var.OS_TYPE}"
      size  = var.DISK_SIZE
      type  = var.DISK_TYPE
    }
    auto_delete = var.AUTO_DELETE_DISK == "true" ? true : false
  }

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.subnet.id


    dynamic "access_config" {
      for_each = var.PUBLIC_IP == "true" ? [1] : []
      content {}
    }
  }

  service_account {
    email  = var.SERVICE_ACCOUNT != "" ? var.SERVICE_ACCOUNT : null
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  metadata = {
    enable-oslogin = "TRUE"
    startup-script = var.ENABLE_STARTUP_SCRIPT == "true" ? file("startup.ps1") : ""
  }

  tags = [
    "windows",
     regex_replace(lower(var.ENVIRONMENT), "^[^a-z]+", "env-")
     ]

  deletion_protection = var.ENABLE_DELETION_PROTECTION == "true" ? true : false

  labels = {
    sistema_operativo = "windows"
    pais              = "pe"
  }
}

# ================================================================
# CONFIGURACIÓN DE FIREWALL
# ================================================================
resource "google_compute_firewall" "firewall_rules" {
  name    = "${var.VM_NAME}-firewall"
  network = var.VPC_NETWORK

  allow {
    protocol = "tcp"
    ports    = ["3389", "5985", "5986"] # RDP y WinRM
  }

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  tags = [
  "windows",
  regex_replace(lower(var.ENVIRONMENT), "^[^a-z]+", "env-")
]
}

# ================================================================
# SALIDAS
# ================================================================
output "vm_name" {
  description = "Nombre de la máquina virtual creada"
  value       = google_compute_instance.vm_windows.name
}

output "vm_zone" {
  description = "Zona donde se creó la máquina virtual"
  value       = google_compute_instance.vm_windows.zone
}

output "vm_public_ip" {
  description = "Dirección IP pública asignada (si aplica)"
  value       = try(google_compute_instance.vm_windows.network_interface[0].access_config[0].nat_ip, "")
}
