variable "PROJECT_ID" {
  description = "ID del proyecto en Google Cloud Platform"
  type        = string
  default     = "jenkins-terraform-demo-472920"
}

variable "REGION" {
  description = "Región de GCP donde se desplegará la VM"
  type        = string
  default     = "us-central1"
}

variable "ZONE" {
  description = "Zona de disponibilidad específica"
  type        = string
  default     = "us-central1-a"
}

variable "ENVIRONMENT" {
  description = "Ambiente de despliegue de la infraestructura"
  type        = string
  default     = "Desarrollo"
}

variable "VM_NAME" {
  description = "Nombre único para la máquina virtual"
  type        = string
  default     = "vm-pe-windows"
}

variable "PROCESSOR_TECH" {
  description = "Tecnología de procesador (n2, e2, ...)"
  type        = string
  default     = "n2"
}

variable "VM_TYPE" {
  description = "Familia de tipo de máquina virtual"
  type        = string
  default     = "n2-standard-2"
}

variable "VM_CORES" {
  description = "Número de vCPUs"
  type        = number
  default     = 2
}

variable "VM_MEMORY" {
  description = "Memoria RAM en GB"
  type        = number
  default     = 8
}

variable "OS_TYPE" {
  description = "Imagen/Family de Windows en windows-cloud"
  type        = string
  default     = "windows-server-2025-dc"
}

variable "DISK_SIZE" {
  description = "Tamaño del disco persistente en GB"
  type        = number
  default     = 100
}

variable "DISK_TYPE" {
  description = "Tipo de disco (pd-ssd, pd-balanced, pd-standard)"
  type        = string
  default     = "pd-ssd"
}

variable "INFRAESTRUCTURE_TYPE" {
  description = "On-demand o Preemptible"
  type        = string
  default     = "On-demand"
}

variable "VPC_NETWORK" {
  description = "Nombre de la red VPC"
  type        = string
  default     = "default"
}

variable "SUBNET" {
  description = "Nombre de la subred dentro de la VPC"
  type        = string
  default     = "vm-subnet"
}

variable "NETWORK_SEGMENT" {
  description = "Segmento de red CIDR"
  type        = string
  default     = "10.0.1.0/24"
}

variable "INTERFACE" {
  description = "Nombre de la interfaz de red principal"
  type        = string
  default     = "nic0"
}

variable "PRIVATE_IP" {
  description = "Asignar dirección IP privada estática"
  type        = bool
  default     = true
}

variable "PUBLIC_IP" {
  description = "Asignar dirección IP pública"
  type        = bool
  default     = false
}

variable "FIREWALL_RULES" {
  description = "Reglas de firewall separadas por comas"
  type        = string
  default     = "allow-rdp,allow-winrm"
}

variable "SERVICE_ACCOUNT" {
  description = "Cuenta de servicio para la VM"
  type        = string
  default     = "gcp-key-platform"
}

variable "LABEL" {
  description = "Etiquetas personalizadas key=value"
  type        = string
  default     = "app=web"
}

variable "ENABLE_STARTUP_SCRIPT" {
  description = "Habilitar script de inicio personalizado"
  type        = bool
  default     = false
}

variable "STARTUP_SCRIPT" {
  description = "Contenido del script de inicio (PowerShell)"
  type        = string
  default     = ""
}

variable "ENABLE_DELETION_PROTECTION" {
  description = "Proteger la VM contra eliminación accidental"
  type        = bool
  default     = false
}

variable "CHECK_DELETE" {
  description = "Solicitar confirmación antes de eliminar recursos"
  type        = bool
  default     = false
}

variable "AUTO_DELETE_DISK" {
  description = "Eliminar automáticamente el disco al eliminar la VM"
  type        = bool
  default     = true
}
