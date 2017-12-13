pipeline {
    agent {
        docker 'postgres'
    }
    stages {
        stage("testing 123") {
            steps {
               echo "hey"
            }
        }
    }

    agent {
        docker 'ruby:2.3.1'
    }
    stages {
        stage("testing 123") {
            steps {
                echo "hey"
            }
        }
    }
}