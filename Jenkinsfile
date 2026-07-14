pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building application...'
            }
        }
    }

    post {
        success {
            emailext(
                to: 'somisettyvasanthkumar@gmail.com',
                subject: "SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
Build Status : SUCCESS

Job Name     : ${env.JOB_NAME}
Build Number : ${env.BUILD_NUMBER}
Build URL    : ${env.BUILD_URL}

The build completed successfully.
"""
            )
        }

        failure {
            emailext(
                to: 'somisettyvasanthkumar@gmail.com',
                subject: "FAILED: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
Build Status : FAILED

Job Name     : ${env.JOB_NAME}
Build Number : ${env.BUILD_NUMBER}
Build URL    : ${env.BUILD_URL}

Please check the console output.
"""
            )
        }

        unstable {
            emailext(
                to: 'somisettyvasanthkumar@gmail.com',
                subject: "UNSTABLE: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
Build Status : UNSTABLE

Job Name     : ${env.JOB_NAME}
Build Number : ${env.BUILD_NUMBER}
Build URL    : ${env.BUILD_URL}
"""
            )
        }
    }
}

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