pipeline {
    agent {
        docker {
            image 'ruby:2.3.1'
            args '-p 3000:3000 -p 5000:5000' 
        }
    }
    environment {
        CI = 'true'
    }
    stages {
        stage('Build') {
            steps {
                sh 'bundle install'
            }
        }
        stage('Test') {
            steps {
                sh 'rspec spec/models/user_spec'
            }
        }
    }
}