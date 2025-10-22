# ================================================================
# CONFIGURACIÓN DE PROYECTO GCP
# ================================================================
PROJECT_ID                = "jenkins-terraform-demo-472920"
REGION                    = "us-central1"
ZONE                      = "us-central1-a"
ENVIRONMENT               = "1-Desarrollo"

# ================================================================
# CONFIGURACIÓN DE LA MÁQUINA VIRTUAL
# ================================================================
VM_NAME                   = "vm-pe-windows"
PROCESSOR_TECH            = "n2"
VM_TYPE                   = "n2-standard"
VM_CORES                  = "2"
VM_MEMORY                 = "8"

# ================================================================
# CONFIGURACIÓN DEL SISTEMA OPERATIVO
# ================================================================
OS_TYPE                   = "windows-2025"

# ================================================================
# CONFIGURACIÓN DE ALMACENAMIENTO
# ================================================================
DISK_SIZE                 = "100"
DISK_TYPE                 = "pd-ssd"

# ================================================================
# CONFIGURACIÓN DE INFRAESTRUCTURA
# ================================================================
INFRAESTRUCTURE_TYPE      = "On-demand"

# ================================================================
# CONFIGURACIÓN DE RED
# ================================================================
VPC_NETWORK               = "default"
SUBNET                    = "subnet-pe-01"
NETWORK_SEGMENT           = "10.0.1.0/24"
INTERFACE                 = "nic0"
PRIVATE_IP                = "true"
PUBLIC_IP                 = "true"

# ================================================================
# CONFIGURACIÓN DE SEGURIDAD
# ================================================================
FIREWALL_RULES            = "allow-rdp,allow-winrm"
SERVICE_ACCOUNT           = "sa-plataforma@jenkins-terraform-demo-472920.iam.gserviceaccount.com"

# ================================================================
# ETIQUETAS Y METADATOS
# ================================================================
LABEL                     = "app=demo,tier=frontend"

# ================================================================
# CONFIGURACIÓN DE SCRIPTS Y ARRANQUE
# ================================================================
ENABLE_STARTUP_SCRIPT      = "false"

# ================================================================
# OPCIONES DE GESTIÓN
# ================================================================
ENABLE_DELETION_PROTECTION = "false"
CHECK_DELETE               = "false"
AUTO_DELETE_DISK           = "true"
