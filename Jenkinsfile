pipeline {
    agent any
    parameters {
        booleanParam defaultValue: false, description: 'deploy using docker', name: 'docker_deploy'
        booleanParam defaultValue: false, description: 'deploy using k8s', name: 'k8s_deploy'
        booleanParam defaultValue: false, description: 'deploy using both docker and k8s', name: 'docker_and_k8s_deploy'
    }

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
            parallel {
                stage('Deploy using Docker') {
                    when {
                        expression { params.docker_deploy == true || params.docker_and_k8s_deploy == true }
                    }

                    input {
                        message 'Deploy?'
                    }
                    steps {
                        echo "Deploying"
                        sh "docker run -d -p 9090:80 abdelrhman11/my_php_app:${BUILD_NUMBER}"
                    }
                }

                stage('Deploy using K8s') {
                    when {
                        expression { params.k8s_deploy == true || params.docker_and_k8s_deploy == true }
                    }

                    input {
                        message 'Deploy?'
                    }
                    steps {
                        echo "Deploying"
                        sh "sed -i 's/placeholder/${BUILD_NUMBER}/' php_deploy_jenkins.yml"
                        sh "kubectl apply -f php_deploy_jenkins.yml"
                    }
                }
            }
        }
    }
}