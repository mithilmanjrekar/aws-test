pipeline {
    agent { docker 'ruby' }
    stages {
        stage('Integration Test') {
            steps {        
                try {
                    //Build the rails app from the Dockerfile 
                    sh "docker build -t rails-app ."
                    //Run postgres container
                    sh "docker run --rm  -d --name postgres postgres"
                    //Run rails container linked with postgres
                    sh "docker run  --rm -d --name rails-connect-to-postgres --link postgres:postgres -p 3000:3000 rails-app rspec spec/models"
                }

                catch(e) {
                    error "Integration Test failed"
                }

                finally {
                    sh "docker rm -f cd-demo || true"
                    sh "docker ps -aq | xargs docker rm || true"
                    sh "docker images -aq -f dangling=true | xargs docker rmi || true"
                }
            }
        }

        stage("Build") {
          sh "echo 'in build'"
        }

        stage("Publish") {
          sh "echo 'in publish'"
        }

    }
}
