pipeline {
    agent any

    tools {
        maven 'maven 3.9.12'
    }

    stages {
        stage('Checkout'){
            steps {
                git branch: 'feature/practice-vasanth', credentialsId: 'github', url: 'https://github.com/vasanthkumar13m/spring-petclinic.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }

        }
        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }
        stage('Deploy To EC2') {
            steps {
                sshPublisher(publishers: [sshPublisherDesc(configName: 'ec2-instance', transfers: [sshTransfer(sourceFiles: 'target/*.jar', removePrefix: 'target', remoteDirectory:'/app')])])
            }
        }
    }
}