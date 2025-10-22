pipeline {
    agent any

    environment {
        PAIS = 'PE'
        SISTEMA_OPERATIVO_BASE = 'Windows'
        SNAPSHOT_ENABLED = 'true'
    }

    options {
        timeout(time: 2, unit: 'HOURS')
        timestamps()
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }

    parameters {
        string(name: 'PROYECT_ID', defaultValue: '', description: 'ID del proyecto en Google Cloud Platform')
        string(name: 'REGION', defaultValue: 'us-central1', description: 'Región de GCP donde se desplegará la VM')
        string(name: 'ZONE', defaultValue: 'us-central1-a', description: 'Zona de disponibilidad específica')
        choice(name: 'ENVIRONMENT', choices: ['1-Desarrollo', '2-Pre productivo (PP)', '3-Producción'], description: 'Ambiente de despliegue de la infraestructura')

        string(name: 'VM_NAME', defaultValue: 'vm-pe-windows', description: 'Nombre único para la máquina virtual')
        choice(name: 'PROCESSOR_TECH', choices: ['n2', 'e2'], description: 'Tecnología de procesador')
        choice(name: 'VM_TYPE', choices: ['n2-standard', 'e2-standard'], description: 'Familia de tipo de máquina virtual')
        string(name: 'VM_CORES', defaultValue: '2', description: 'Número de vCPUs para la máquina virtual')
        string(name: 'VM_MEMORY', defaultValue: '8', description: 'Memoria RAM en GB')
        choice(name: 'OS_TYPE', choices: ['windows-2025', 'windows-2025-core', 'windows-2022'], description: 'Versión del sistema operativo')
        string(name: 'DISK_SIZE', defaultValue: '100', description: 'Tamaño del disco persistente en GB')
        choice(name: 'DISK_TYPE', choices: ['pd-ssd', 'pd-balanced', 'pd-standard'], description: 'Tipo de disco')
        choice(name: 'INFRAESTRUCTURE_TYPE', choices: ['On-demand', 'Preemptible'], description: 'Tipo de infraestructura')

        string(name: 'VPC_NETWORK', defaultValue: 'default', description: 'Nombre de la red VPC')
        string(name: 'SUBNET', defaultValue: 'subnet-pe-01', description: 'Nombre de la subred')
        string(name: 'NETWORK_SEGMENT', defaultValue: '10.0.1.0/24', description: 'Segmento de red CIDR')
        string(name: 'INTERFACE', defaultValue: 'nic0', description: 'Nombre de la interfaz de red principal')
        choice(name: 'PRIVATE_IP', choices: ['true', 'false'], description: 'Asignar IP privada estática')
        choice(name: 'PUBLIC_IP', choices: ['false', 'true'], description: 'Asignar IP pública externa')

        string(name: 'FIREWALL_RULES', defaultValue: 'allow-rdp,allow-winrm', description: 'Reglas de firewall separadas por comas')
        string(name: 'SERVICE_ACCOUNT', defaultValue: 'sa-plataforma@jenkins-terraform-demo-472920.iam.gserviceaccount.com', description: 'Cuenta de servicio para la VM')
        string(name: 'LABEL', defaultValue: '', description: 'Etiquetas personalizadas para la VM')
        choice(name: 'ENABLE_STARTUP_SCRIPT', choices: ['false', 'true'], description: 'Habilitar script de inicio personalizado')
        choice(name: 'ENABLE_DELETION_PROTECTION', choices: ['false', 'true'], description: 'Proteger la VM contra eliminación accidental')
        choice(name: 'CHECK_DELETE', choices: ['false', 'true'], description: 'Solicitar confirmación antes de eliminar recursos')
        choice(name: 'AUTO_DELETE_DISK', choices: ['true', 'false'], description: 'Eliminar automáticamente el disco al eliminar la VM')
    }

    stages {
        stage('Validación de Parámetros') {
            steps {
                script {
                    echo "================================================"
                    echo "         VALIDACIÓN DE PARÁMETROS              "
                    echo "================================================"

                    def errores = []

                    // Tu código de validación de SUBNET y NETWORK_SEGMENT
                    if (!params.SUBNET?.trim()) {
                        errores.add("El parámetro SUBNET no puede estar vacío")
                    }
                    if (!params.NETWORK_SEGMENT?.trim()) {
                        errores.add("El parámetro NETWORK_SEGMENT no puede estar vacío")
                    }

                    if (errores.size() > 0) {
                        echo "Errores de validación:"
                        errores.each { echo "  - ${it}" }
                        error("Validación de parámetros fallida")
                    }

                    echo "Validación de parámetros completada exitosamente"
                }
            }
        }

        stage('Mostrar Configuración') {
            steps {
                script {
                    echo "Proyecto: ${params.PROYECT_ID}"
                    echo "Región: ${params.REGION}"
                    echo "Zona: ${params.ZONE}"
                    echo "Nombre VM: ${params.VM_NAME}"
                    echo "Tipo de OS: ${params.OS_TYPE}"
                }
            }
        }

        stage('Resumen Pre-Despliegue') {
            steps {
                script {
                    echo "================================================"
                    echo "              RESUMEN DE CONFIGURACIÓN         "
                    echo "================================================"
                    echo "Sistema Operativo Base: ${env.SISTEMA_OPERATIVO_BASE}"
                    echo "Tipo de Procesador: ${params.PROCESSOR_TECH}"
                    echo "Memoria RAM (GB): ${params.VM_MEMORY}"
                    echo "Disco (GB): ${params.DISK_SIZE}"
                    echo "Infraestructura: ${params.INFRAESTRUCTURE_TYPE}"
                }
            }
        }

        stage('Terraform Init & Plan') {
            steps {
                dir('terraform') {
                    script {
                        withCredentials([file(credentialsId: 'gcp-sa-platform', variable: 'GOOGLE_CREDENTIALS')]) {
                            sh """
                                export GOOGLE_APPLICATION_CREDENTIALS=\$GOOGLE_CREDENTIALS
                                echo '================================================'
                                echo '              INICIALIZANDO TERRAFORM          '
                                echo '================================================'
                                terraform init
                                echo '================================================'
                                echo '              EJECUTANDO PLAN DE TERRAFORM      '
                                echo '================================================'
                                terraform plan -out=tfplan
                            """
                        }
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    script {
                        withCredentials([file(credentialsId: 'gcp-sa-platform', variable: 'GOOGLE_CREDENTIALS')]) {
                            sh """
                                export GOOGLE_APPLICATION_CREDENTIALS=\$GOOGLE_CREDENTIALS
                                echo '================================================'
                                echo '             EJECUTANDO APPLY DE TERRAFORM      '
                                echo '================================================'
                                terraform apply tfplan
                            """
                        }
                    }
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { return params.ENVIRONMENT == '3-Producción' }
            }
            steps {
                dir('terraform') {
                    script {
                        withCredentials([file(credentialsId: 'gcp-sa-platform', variable: 'GOOGLE_CREDENTIALS')]) {
                            sh """
                                export GOOGLE_APPLICATION_CREDENTIALS=\$GOOGLE_CREDENTIALS
                                echo '================================================'
                                echo '             EJECUTANDO DESTROY DE TERRAFORM    '
                                echo '================================================'
                                terraform destroy -auto-approve
                            """
                        }
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline ejecutado exitosamente"
        }
        failure {
            echo "Pipeline falló durante la ejecución"
        }
        always {
            echo "================================================"
            echo "            FIN DE LA EJECUCIÓN                "
            echo "  Fecha: ${new Date()}"
            echo "================================================"
        }
    }
}
