pipeline {
    agent {
        docker {
            image 'ruby:2.3.1'
            args '--name rails-app -p 3000:3000 ' 
        }
    }
    environment {
        CI = 'true'
    }
    stages {
        stage('Build') {
            steps {
                
                sh 'gem install bundler'
                sh 'gem install uglifier'
                sh 'gem install rspec'
                sh 'bundle update'
                sh 'bundle install'
            }
        }
        stage('Test') {
            steps {
                sh 'rspec spec/models'
            }
        }
    }
}