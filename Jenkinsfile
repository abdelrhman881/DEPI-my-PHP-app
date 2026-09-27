node {
    stage('Source') { 
        git branch: 'main', credentialsId: 'github_cred', url: 'https://github.com/abdelrhman881/DEPI-my-PHP-app.git'
    }

    stage('Build & Push') {
        echo "Building"
        def newApp = docker.build "abdelrhman11/my_php_app:${BUILD_NUMBER}"
        echo "Pushing"
        withDockerRegistry(credentialsId: 'dockerhub_cred', url: 'https://index.docker.io/v1/') {
            newApp.push()
        }
    }

    stage('Deploy') {
        input message: "Deploy?"
        echo "Deploying"
        sh "docker run -d -p 9090:80 abdelrhman11/my_php_app:${BUILD_NUMBER}"
    }
}
