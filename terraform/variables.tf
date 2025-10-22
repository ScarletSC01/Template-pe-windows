variable "PROJECT_ID" {
  description = "ID del proyecto en Google Cloud Platform"
  type        = string
}

variable "REGION" {
  description = "Región de GCP"
  type        = string
}

variable "ZONE" {
  description = "Zona de GCP"
  type        = string
}

variable "ENVIRONMENT" {
  description = "Ambiente de despliegue (1-Desarrollo, 2-Test, 3-Prod)"
  type        = string
}

variable "VM_NAME" {
  description = "Nombre de la VM"
  type        = string
}

variable "PROCESSOR_TECH" {
  description = "Tecnología de procesador"
  type        = string
}

variable "VM_TYPE" {
  description = "Familia de máquina virtual"
  type        = string
}

variable "VM_CORES" {
  description = "Número de vCPUs"
  type        = number
}

variable "VM_MEMORY" {
  description = "Memoria RAM en GB"
  type        = number
}

variable "OS_TYPE" {
 description = "Familia de Windows a usar (ej: windows-2025, windows-2025-core)"
  type        = string
  default     = "windows-2025"
}

variable "DISK_SIZE" {
  description = "Tamaño del disco persistente en GB"
  type        = number
}

variable "DISK_TYPE" {
  description = "Tipo de disco (pd-ssd, pd-balanced, pd-standard)"
  type        = string
}

variable "INFRAESTRUCTURE_TYPE" {
  description = "Tipo de infraestructura (On-demand o Preemptible)"
  type        = string
}

variable "VPC_NETWORK" {
  description = "Nombre de la red VPC"
  type        = string
}

variable "SUBNET" {
  description = "Nombre de la subred"
  type        = string
}

variable "NETWORK_SEGMENT" {
  description = "Segmento de red CIDR"
  type        = string
}

variable "INTERFACE" {
  description = "Interfaz de red principal"
  type        = string
}

# Cambiados a string porque Jenkins usa choice
variable "PRIVATE_IP" {
  description = "Asignar IP privada estática (true/false)"
  type        = string
}

variable "PUBLIC_IP" {
  description = "Asignar IP pública (true/false)"
  type        = string
}

variable "FIREWALL_RULES" {
  description = "Reglas de firewall separadas por comas"
  type        = string
}

variable "SERVICE_ACCOUNT" {
  description = "Cuenta de servicio"
  type        = string
}

variable "LABEL" {
  description = "Etiquetas personalizadas (key=value)"
  type        = string
}

variable "ENABLE_STARTUP_SCRIPT" {
  description = "Habilitar script de inicio"
  type        = string
}

variable "ENABLE_DELETION_PROTECTION" {
  description = "Proteger contra eliminación"
  type        = string
}

variable "CHECK_DELETE" {
  description = "Confirmar antes de eliminar recursos"
  type        = string
}

variable "AUTO_DELETE_DISK" {
  description = "Eliminar disco con la VM"
  type        = string
}
