# ================================================================
# VARIABLES GENERALES
# ================================================================
variable "PROJECT_ID" {
  type        = string
  description = "ID del proyecto de GCP"
}

variable "REGION" {
  type        = string
  default     = "us-central1"
  description = "Región donde se desplegará la VM"
}

variable "ZONE" {
  type        = string
  default     = "us-central1-a"
  description = "Zona dentro de la región"
}

variable "ENVIRONMENT" {
  type        = string
  default     = "dev"
  description = "Entorno de despliegue (dev, prod, etc.)"
}

# ================================================================
# VARIABLES DE RED
# ================================================================
variable "VPC_NETWORK" {
  type        = string
  description = "Nombre de la VPC"
}

variable "SUBNET" {
  type        = string
  description = "Nombre de la subred"
}

variable "NETWORK_SEGMENT" {
  type        = string
  description = "Segmento IP de la subred (ej. 10.0.0.0/24)"
}

# ================================================================
# VARIABLES DE MÁQUINA VIRTUAL
# ================================================================
variable "VM_NAME" {
  type        = string
  description = "Nombre de la máquina virtual"
}

variable "VM_TYPE" {
  type        = string
  default     = "n1-standard"
  description = "Tipo de máquina base"
}

variable "VM_CORES" {
  type        = number
  default     = 1
  description = "Número de CPUs"
}

variable "OS_TYPE" {
  type        = string
  default     = "windows-2022"
  description = "Sistema operativo (windows-2016, windows-2022, windows-2025)"
}

variable "DISK_SIZE" {
  type        = number
  default     = 50
  description = "Tamaño del disco en GB"
}

variable "DISK_TYPE" {
  type        = string
  default     = "pd-standard"
  description = "Tipo de disco (pd-standard, pd-ssd)"
}

variable "AUTO_DELETE_DISK" {
  type        = string
  default     = "true"
  description = "Si el disco se elimina al borrar la VM (true/false)"
}

variable "PUBLIC_IP" {
  type        = string
  default     = "true"
  description = "Si la VM tendrá IP pública (true/false)"
}

variable "SERVICE_ACCOUNT" {
  type        = string
  default     = ""
  description = "Email de la cuenta de servicio"
}

variable "ENABLE_STARTUP_SCRIPT" {
  type        = string
  default     = "false"
  description = "Si se ejecuta un startup script (true/false)"
}

variable "ENABLE_DELETION_PROTECTION" {
  type        = string
  default     = "false"
  description = "Protege la VM contra eliminación (true/false)"
}
