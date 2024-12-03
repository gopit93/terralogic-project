pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'
        DOCKERHUB_USERNAME = 'dockerhub-username'
        REPO_NAME = 'terralogic-project.git'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/gopit93/terralogic-project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def commitHash = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
                    def branchName = sh(returnStdout: true, script: 'git rev-parse --abbrev-ref HEAD').trim()
                    env.IMAGE_TAG = "${branchName}-${commitHash}"
                    sh "docker build -t ${DOCKERHUB_USERNAME}/${REPO_NAME}:${IMAGE_TAG} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withDockerRegistry([credentialsId: DOCKER_CREDENTIALS_ID, url: '']) {
                        sh "docker push ${DOCKERHUB_USERNAME}/${REPO_NAME}:${IMAGE_TAG}"
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Docker image pushed successfully: ${DOCKERHUB_USERNAME}/${REPO_NAME}:${IMAGE_TAG}"
        }
        failure {
            echo "Pipeline failed."
        }
    }
}
