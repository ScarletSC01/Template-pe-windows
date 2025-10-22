# ================================================================
# VARIABLES DE PROYECTO GCP
# ================================================================
variable "PROJECT_ID" {
  type        = string
  description = "ID del proyecto de GCP"
}

variable "REGION" {
  type        = string
  description = "Región de despliegue"
}

variable "ZONE" {
  type        = string
  description = "Zona de despliegue"
}

variable "ENVIRONMENT" {
  type        = string
  description = "Nombre del entorno"
}

# ================================================================
# VARIABLES DE MÁQUINA VIRTUAL
# ================================================================
variable "VM_NAME" {
  type        = string
  description = "Nombre de la máquina virtual"
}

variable "PROCESSOR_TECH" {
  type        = string
  description = "Tipo de procesador"
}

variable "VM_TYPE" {
  type        = string
  description = "Tipo de VM"
}

variable "VM_CORES" {
  type        = string
  description = "Cantidad de núcleos"
}

variable "VM_MEMORY" {
  type        = string
  description = "Cantidad de memoria en GB"
}

# ================================================================
# VARIABLES DE SISTEMA OPERATIVO
# ================================================================
variable "OS_TYPE" {
  type        = string
  description = "Imagen de Windows a usar"
}

# ================================================================
# VARIABLES DE ALMACENAMIENTO
# ================================================================
variable "DISK_SIZE" {
  type        = string
  description = "Tamaño del disco en GB"
}

variable "DISK_TYPE" {
  type        = string
  description = "Tipo de disco"
}

variable "AUTO_DELETE_DISK" {
  type        = string
  description = "Si el disco se borra al eliminar la VM ('true'/'false')"
}

# ================================================================
# VARIABLES DE RED
# ================================================================
variable "VPC_NETWORK" {
  type        = string
  description = "Nombre de la red VPC"
}

variable "SUBNET" {
  type        = string
  description = "Nombre de la subred"
}

variable "NETWORK_SEGMENT" {
  type        = string
  description = "Segmento IP de la subred"
}

variable "INTERFACE" {
  type        = string
  description = "Nombre de la interfaz de red"
}

variable "PRIVATE_IP" {
  type        = string
  description = "Si la VM tiene IP privada ('true'/'false')"
}

variable "PUBLIC_IP" {
  type        = string
  description = "Si la VM tiene IP pública ('true'/'false')"
}

# ================================================================
# VARIABLES DE SEGURIDAD
# ================================================================
variable "FIREWALL_RULES" {
  type        = string
  description = "Reglas de firewall a aplicar"
}

variable "SERVICE_ACCOUNT" {
  type        = string
  description = "Cuenta de servicio a usar"
}

# ================================================================
# VARIABLES DE ETIQUETAS Y METADATOS
# ================================================================
variable "LABEL" {
  type        = string
  description = "Etiquetas y metadata de la VM"
}

# ================================================================
# VARIABLES DE SCRIPTS Y ARRANQUE
# ================================================================
variable "ENABLE_STARTUP_SCRIPT" {
  type        = string
  description = "Habilitar script de arranque ('true'/'false')"
}

# ================================================================
# VARIABLES DE GESTIÓN
# ================================================================
variable "ENABLE_DELETION_PROTECTION" {
  type        = string
  description = "Habilitar protección de borrado ('true'/'false')"
}

variable "CHECK_DELETE" {
  type        = string
  description = "Verificación de borrado ('true'/'false')"
}

variable "INFRAESTRUCTURE_TYPE" {
  type        = string
  description = "Tipo de infraestructura"
}
