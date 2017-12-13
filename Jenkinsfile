pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                app1 = docker.build("potgres")
                app2 = docker.build("ruby")
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