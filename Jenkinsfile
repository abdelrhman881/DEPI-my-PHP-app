pipeline {
    agent any

    stages {
        stage('Build & Push') {
            steps {
                script {
                    echo "Building"
                    def newApp=docker.build "abdelrhman11/my_php_app:${BUILD_NUMBER}"
                    echo "Pushing"
                    withDockerRegistry(credentialsId:'dockerhub_cred',url:'https://index.docker.io/v1/') {
                        newApp.push()
                    }
                }
            }
        }

        stage('Deploy') {
            input {
                message 'Deploy?'
            }
            steps {
                echo "Deploying"
                sh "docker run -d -p 9090:80 abdelrhman11/my_php_app:${BUILD_NUMBER}"
            }
        }
    }
}