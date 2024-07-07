pipeline {
    agent {
        label 'Agent-1'
    }
    options {
        timeout(time: 30, unit: 'MINUTES') 
        disableConcurrentBuilds()
        ansiColor('xterm')
    }
    stages {
        stage('init') {
            steps {
                sh """

                """
            }
        }
        stage('plan') {
            steps {
                sh """

                """
            }
        }
        stage('Deploy') {
            steps {
                sh """

                """
            }
        }
    }
        post { 
            always { 
                echo 'I will always say Hello again!'
            }
            success {
                echo 'i will run the pipeline is usccess'
            }
            failure {
                echo 'i will the pipeline is failure'
            }
        }
}