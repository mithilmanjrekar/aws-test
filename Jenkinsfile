pipeline {
    agent { docker 'ruby' }
    stages {
        stage('Integration Test') {
            steps {
                checkout scm

                //Build the rails app from the Dockerfile 
                sh "docker build -t rails-app ."
                //Run postgres container
                sh "docker run --rm  -d --name postgres postgres"
                //Run rails container linked with postgres
                sh "docker run  --rm -d --name rails-connect-to-postgres --link postgres:postgres -p 3000:3000 rails-app rspec spec/models"
            }
        }
    }
}
