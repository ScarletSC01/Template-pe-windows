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
        // ========================================
        // CONFIGURACIÓN DE PROYECTO GCP
        // ========================================
        string(name: 'PROYECT_ID', defaultValue: '', description: 'ID del proyecto en Google Cloud Platform')
        string(name: 'REGION', defaultValue: 'us-central1', description: 'Región de GCP donde se desplegará la VM (ejemplo: us-central1, southamerica-west1)')
        string(name: 'ZONE', defaultValue: 'us-central1-a', description: 'Zona de disponibilidad específica (ejemplo: us-central1-a, southamerica-west1-b)')
        choice(name: 'ENVIRONMENT', choices: ['1-Desarrollo', '2-Pre productivo (PP)', '3-Producción'], description: 'Ambiente de despliegue de la infraestructura')

        // ========================================
        // CONFIGURACIÓN DE LA MÁQUINA VIRTUAL
        // ========================================
        string(name: 'VM_NAME', defaultValue: '', description: 'Nombre único para la máquina virtual (debe cumplir con convenciones de nomenclatura de GCP)')
        choice(name: 'PROCESSOR_TECH', choices: ['n2', 'e2'], description: 'Tecnología de procesador (N2: Intel Cascade Lake o Ice Lake, E2: Última generación optimizada para costos)')
        choice(name: 'VM_TYPE', choices: ['n2-standard', 'e2-standard'], description: 'Familia de tipo de máquina virtual')
        string(name: 'VM_CORES', defaultValue: '2', description: 'Número de vCPUs para la máquina virtual (ejemplo: 2, 4, 8)')
        string(name: 'VM_MEMORY', defaultValue: '8', description: 'Memoria RAM en GB (ejemplo: 4, 8, 16, 32)')

        // ========================================
        // CONFIGURACIÓN DEL SISTEMA OPERATIVO
        // ========================================
        choice(name: 'OS_TYPE', choices: ['Windows-server-2025-dc', 'Windows-server-2022-dc', 'Windows-server-2019-dc'], description: 'Versión del sistema operativo Windows Server Datacenter')

        // ========================================
        // CONFIGURACIÓN DE ALMACENAMIENTO
        // ========================================
        string(name: 'DISK_SIZE', defaultValue: '100', description: 'Tamaño del disco persistente en GB (mínimo 50 GB para Windows Server)')
        choice(name: 'DISK_TYPE', choices: ['pd-ssd', 'pd-balanced', 'pd-standard'], description: 'Tipo de disco (SSD: Mayor rendimiento, Balanced: Equilibrio, Standard: Económico)')

        // ========================================
        // CONFIGURACIÓN DE INFRAESTRUCTURA
        // ========================================
        choice(name: 'INFRAESTRUCTURE_TYPE', choices: ['On-demand', 'Preemptible'], description: 'Tipo de infraestructura (On-demand: Siempre disponible, Preemptible: Hasta 80% más económico pero puede interrumpirse)')

        // ========================================
        // CONFIGURACIÓN DE RED
        // ========================================
        string(name: 'VPC_NETWORK', defaultValue: 'default', description: 'Nombre de la red VPC (Virtual Private Cloud)')
        string(name: 'SUBNET', defaultValue: 'subnet-pe-01', description: 'Nombre de la subred dentro de la VPC')
        string(name: 'NETWORK_SEGMENT', defaultValue: '10.0.1.0/24', description: 'Segmento de red CIDR (ejemplo: 10.0.1.0/24, 192.168.1.0/24)')
        string(name: 'INTERFACE', defaultValue: 'nic0', description: 'Nombre de la interfaz de red principal')
        choice(name: 'PRIVATE_IP', choices: ['true', 'false'], description: 'Asignar dirección IP privada estática')
        choice(name: 'PUBLIC_IP', choices: ['false', 'true'], description: 'Asignar dirección IP pública (externa) a la VM')

        // ========================================
        // CONFIGURACIÓN DE SEGURIDAD
        // ========================================
        string(name: 'FIREWALL_RULES', defaultValue: 'allow-rdp,allow-winrm', description: 'Reglas de firewall separadas por comas (ejemplo: allow-rdp,allow-winrm,allow-https)')
        string(name: 'SERVICE_ACCOUNT', defaultValue: '', description: 'Cuenta de servicio para la VM (dejar vacío para usar la cuenta predeterminada)')

        // ========================================
        // ETIQUETAS Y METADATOS
        // ========================================
        string(name: 'LABEL', defaultValue: '', description: 'Etiquetas personalizadas para la VM en formato key=value (ejemplo: app=web,tier=frontend)')

        // ========================================
        // CONFIGURACIÓN DE SCRIPTS Y ARRANQUE
        // ========================================
        choice(name: 'ENABLE_STARTUP_SCRIPT', choices: ['false', 'true'], description: 'Habilitar script de inicio personalizado')

        // ========================================
        // OPCIONES DE GESTIÓN
        // ========================================
        choice(name: 'ENABLE_DELETION_PROTECTION', choices: ['false', 'true'], description: 'Proteger la VM contra eliminación accidental')
        choice(name: 'CHECK_DELETE', choices: ['false', 'true'], description: 'Solicitar confirmación antes de eliminar recursos')
        choice(name: 'AUTO_DELETE_DISK', choices: ['true', 'false'], description: 'Eliminar automáticamente el disco al eliminar la VM')
    }

    stages {
        stage('Validación de Parámetros') {
            steps {
                script {
                    echo '================================================'
                    echo '         VALIDACIÓN DE PARÁMETROS              '
                    echo '================================================'

                    def errores = []
                    // ... (tu código de validación sigue igual)

                    if (errores.size() > 0) {
                        echo 'Errores de validación:'
                        errores.each { echo "  - ${it}" }
                        error('Validación de parámetros fallida')
                    }

                    echo 'Validación de parámetros completada exitosamente'
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
                    echo '================================================'
                    echo '              RESUMEN DE CONFIGURACIÓN         '
                    echo '================================================'
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
                withCredentials([file(credentialsId: 'gcp-key-platform', variable: 'GOOGLE_CREDENTIALS')]) {
                    echo '================================================'
                    echo '              INICIALIZANDO TERRAFORM          '
                    echo '================================================'
                    sh '''
                    export GOOGLE_APPLICATION_CREDENTIALS=$GOOGLE_CREDENTIALS
                    terraform init

                    echo '================================================'
                    echo '              EJECUTANDO PLAN DE TERRAFORM      '
                    echo '================================================'
                    terraform plan -out=tfplan
                    '''
                }
            }
        }
    }
}

stage('Terraform Apply') {
    steps {
        dir('terraform') {
            script {
                withCredentials([file(credentialsId: 'gcp-key-platform', variable: 'GOOGLE_CREDENTIALS')]) {
                    sh '''
                    export GOOGLE_APPLICATION_CREDENTIALS=$GOOGLE_CREDENTIALS
                    echo '================================================'
                    echo '             EJECUTANDO APPLY DE TERRAFORM      '
                    echo '================================================'
                    terraform apply tfplan
                    '''
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
                withCredentials([file(credentialsId: 'gcp-key-platform', variable: 'GOOGLE_CREDENTIALS')]) {
                    sh '''
                    export GOOGLE_APPLICATION_CREDENTIALS=$GOOGLE_CREDENTIALS
                    echo '================================================'
                    echo '             EJECUTANDO DESTROY DE TERRAFORM    '
                    echo '================================================'
                    terraform destroy -auto-approve
                    '''
                }
            }
        }
    }
}
    post {
        success {
            echo '\nPipeline ejecutado exitosamente'
        }
        failure {
            echo '\nPipeline falló durante la ejecución'
        }
        always {
            echo '\n================================================'
            echo '            FIN DE LA EJECUCIÓN                '
            echo "  Fecha: ${new Date()}"
            echo '================================================'
        }
    }
}
