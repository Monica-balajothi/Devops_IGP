pipeline {
    agent any

    tools {
        maven 'Maven' // Ensure Maven is configured in Jenkins Global Tool Configuration
    }

    environment {
        MAVEN_OPTS = '-Xmx256m' // Limit Maven memory usage
        DOCKER_BUILDKIT = '1'  // Use Docker BuildKit for faster builds
    }

    stages {
        stage('Code Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Monica-balajothi/Devops_IGP.git'
            }
        }

        stage('Code Compile') {
            steps {
                sh 'mvn clean compile -Dmaven.repo.local=${WORKSPACE}/.m2'
            }
        }

        stage('Unit Test') {
            steps {
                sh 'mvn test -Dmaven.repo.local=${WORKSPACE}/.m2'
            }
        }

        stage('Code Packaging') {
            steps {
                sh 'mvn package -Dmaven.repo.local=${WORKSPACE}/.m2'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh '''
                    docker build --memory=256m -t monicabalajothi/retail-app:${BUILD_NUMBER} -t monicabalajothi/retail-app:latest .
                    '''
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withDockerRegistry([credentialsId: 'dockerhub-id', url: '']) {
                        sh '''
                        docker push monicabalajothi/retail-app:${BUILD_NUMBER}
                        docker push monicabalajothi/retail-app:latest
                        '''
                    }
                }
            }
        }

        stage('Deploy as Container') {
            steps {
                sh '''
                docker run --memory=256m -itd -p 8081:8080 monicabalajothi/retail-app:latest
                '''
            }
        }
    }

    post {
        always {
            cleanWs() // Clean up workspace to free up disk space
        }
    }
}
