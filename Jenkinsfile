pipeline {
    agent any

    stages {

        stage('Build') {

            steps {

                echo 'Building..'

                checkout scm

                stage("Install Bundler") {
                    sh "docker ps"
                }

                stage("Use Bundler to install dependencies") {
                    sh "docker ps"
                }

                stage("Build package") {
                    sh "docker ps"
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
