pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-cred') // ID dari Jenkins credentials
        IMAGE_NAME = 'mondaysee/jenkins-maven-demo'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/<username>/jenkins-maven-demo.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $IMAGE_NAME:1.0 .'
                    sh 'docker tag $IMAGE_NAME:1.0 $IMAGE_NAME:1.1'
                    sh 'docker tag $IMAGE_NAME:1.0 $IMAGE_NAME:2.0'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
                    sh "docker push $IMAGE_NAME:1.0"
                    sh "docker push $IMAGE_NAME:1.1"
                    sh "docker push $IMAGE_NAME:2.0"
                }
            }
        }
    }

    post {
        success {
            echo 'Build and push successful!'
        }
        failure {
            echo 'Build failed.'
        }
    }
}
