pipeline {
    agent any
    parameters {
        choice(
            name: 'ENVIRONMENT'
            choices: ['DEV', 'QA', 'TEST', 'PROD']
            description: 'Select the Enviroments for Deploy'
            )
        booleanParam(
            name: 'DEPLOY',
            defaultValue: true,
            description: 'Deploy the Spring APP'
            )
        string(
            name: 'VERSION',
            defaultValue: '1.0.0',
            description: 'Spring APP Version'
            )
    tools {
        maven 'maven'
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
