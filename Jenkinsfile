pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'monicabalajothi/retail-app:latest' // Your Docker Hub image name
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/Monica-balajothi/Devops_IGP.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Package') {
            steps {
                sh 'mvn package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Docker Login & Push') {
            steps {
                script {
                    withDockerRegistry([credentialsId: 'dockerhub-id', url: 'https://registry.hub.docker.com']) {
                        sh "docker push ${DOCKER_IMAGE}"
                    }
                }
            }
        }

        stage('Deploy with Ansible') {
            steps {
                sh 'ansible-playbook -i inventory/hosts deploy.yml'
            }
        }
    }
}
