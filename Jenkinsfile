pipeline {
    agent any

    stages {

        stage('Build') {

            steps {

                echo 'Building..'

                checkout scm

                sh "docker ps"
               
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
