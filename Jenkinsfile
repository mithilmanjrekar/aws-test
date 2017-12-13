pipeline {
    agent any

    stages {

        stage('Build') {

            steps {

                    echo 'Building..'

                    checkout scm

                    checkout scm
                    
                    sh "docker build --rm -t rails-app ./"

                    docker.image('rails-app').inside {

                        stage("Install Bundler") {
                            sh "gem install bundler --no-rdoc --no-ri"
                        }

                        stage("Use Bundler to install dependencies") {
                            sh "bundle install"
                        }

                        stage("Build package") {
                            sh "bundle exec rake build:deb"
                        }

                        stage("Archive package") {
                            archive (includes: 'pkg/*.deb')
                        }

                   }

            }

        }

        stage('Test') {

            steps {

                echo 'Testing..'

            }

        }

        stage('Deploy') {

            steps {

                echo 'Deploying....'

            }

        }

    }

}
