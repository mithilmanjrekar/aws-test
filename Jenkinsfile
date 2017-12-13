pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                app = docker.build("potgres")
                app = docker.build("ruby")
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