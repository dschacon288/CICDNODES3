pipeline {
    agent any

    environment {
        NODE_VERSION = "15.14.0" // Versión específica de Node.js
    }

    stages {
        stage('Checkout repository') {
            steps {
                echo 'Clonando el repositorio...'
                checkout scm
            }
        }

        stage('Set up Node.js') {
            steps {
                echo "Configurando Node.js versión ${NODE_VERSION}..."
                // Usar NVM para instalar y usar la versión requerida
                sh '''
                export NVM_DIR="$HOME/.nvm"
                [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
                nvm install ${NODE_VERSION}
                nvm use ${NODE_VERSION}
                node -v
                npm -v
                '''
            }
        }

        stage('Install dependencies') {
            steps {
                echo 'Instalando dependencias...'
                sh 'npm install'
            }
        }

        stage('Run linter') {
            steps {
                echo 'Ejecutando linter...'
                sh 'npm run lint'
            }
        }

        stage('Run Prettier') {
            steps {
                echo 'Ejecutando Prettier...'
                sh 'npm run prettier'
            }
        }

        stage('Run tests') {
            steps {
                echo 'Ejecutando pruebas...'
                sh 'npm run test'
            }
        }

        stage('Build application') {
            steps {
                echo 'Construyendo la aplicación...'
                sh 'npm run build'
            }
        }
    }

    post {
        always {
            echo 'Pipeline finalizado.'
        }
        success {
            echo 'Pipeline ejecutado con éxito.'
        }
        failure {
            echo 'Pipeline falló.'
        }
    }
}